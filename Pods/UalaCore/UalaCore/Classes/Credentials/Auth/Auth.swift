import Foundation
import PromiseKit
import Auth0

class Auth {
    private var authConfig: AuthConfig
    private var authentication: Authentication
    private var credentialsManager: CredentialsManager
    private var oob: String?
    private var MFA: MFAClient
    private var idleRefreshTokenTimer: Timer?
    private var timeoutInSeconds: TimeInterval {
        return 300
    }
    
    init() {
        let environment: Environment = ServiceLocator.inject()
        authConfig = environment.authConfig
        MFA = MFAClient(config: authConfig)
        authentication = Auth0.authentication(clientId: authConfig.clientId, domain: authConfig.domain)
        credentialsManager = CredentialsManager(authentication: authentication)
    }
    
    deinit {
        idleRefreshTokenTimer?.invalidate()
        idleRefreshTokenTimer = nil
    }
}

private extension Auth {
    private func resetIdleTimer() {
        if let idleTimer = idleRefreshTokenTimer {
            idleTimer.invalidate()
        }

        DispatchQueue.main.async {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        idleRefreshTokenTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds,
                                                     target: self,
                                                     selector: #selector(refreshTokenTimerHasExceeded),
                                                     userInfo: nil,
                                                     repeats: false)
    }

    @objc private func refreshTokenTimerHasExceeded() {
        guard let account = UserSessionData.account, account.status == .valid || account.status == .blacklisted else { return }
        
        refreshAccessToken().done { [weak self] _ in
            self?.resetIdleTimer()
        }.catch { _ in }
    }
}

extension Auth: Credentials {
    
    var isUserSignedIn: Bool {
        credentialsManager.hasValid()
    }
        
    func getToken() -> Promise<String> {
        return Promise { seal in
            resetIdleTimer()
            getAccessToken().done { token in
                seal.fulfill("Bearer \(token)")
            }.catch { error in
                if error as? UalaError == UalaError.auth0InusualActivity {
                    NotificationCenter.default.post(Notification(name: Notification.Name.inusualActivity))
                }
                seal.reject(error)
            }
        }
    }
    
    private func getAccessToken() -> Promise<String> {
        return Promise { seal in
            credentialsManager.credentials { error, credentials in
                if let error = error {
                    if error.isInusualBehaviour {
                        return seal.reject(UalaError.auth0InusualActivity)
                    } else {
                        return seal.reject(UalaError.undefined)
                    }
                }
                
                guard let token = credentials?.accessToken else {
                    return seal.reject(UalaError.undefined)
                }
                seal.fulfill(token)
            }
        }
    }

    private func getRefreshToken() -> Promise<String> {
        return Promise { seal in
            credentialsManager.credentials { _, credentials in
                guard let refreshToken = credentials?.refreshToken else {
                    return seal.reject(UalaError.undefined)
                }
                seal.fulfill(refreshToken)
            }
        }
    }
    
    func refreshAccessToken() -> Promise<Void> {
        return Promise<Void> { seal in
            firstly {
                getRefreshToken()
            }.then { refreshToken -> Promise<Void> in
                self.renewAccessToken(refreshToken: refreshToken)
            }.done { _ in
                seal.fulfill_()
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    func login(username: String, password: String) -> Promise<Void> {
        return Promise { seal in
            let parameters: [String: String] = getLoginParameters()
            authentication
                .login(usernameOrEmail: username,
                       password: password,
                       realm: authConfig.database,
                       audience: authConfig.audience,
                       scope: authConfig.defaultScope,
                       parameters: parameters)
                .start {
                    switch $0 {
                    case .failure(let error):
                        self.signOut()
                        guard let authError = error as? Auth0.AuthenticationError else {
                            seal.reject(UalaError.undefined)
                            return
                        }
                        if authError.isAccountNotVerified {
                            seal.reject(UalaError.accountNotVerified)
                        } else if authError.isMultifactorRequired, let token = authError.info["mfa_token"] as? String {
                            let credentials = CredentialBuilder.create(token: token)
                            _ = self.credentialsManager.store(credentials: credentials)
                            seal.reject(UalaError.MFARequired)
                        } else if authError.secondLoginDenied {
                            seal.reject(UalaError.secondLoginRejected)
                        } else if authError.isAccountBlocked {
                            seal.reject(UalaError.accountBlocked)
                        } else if authError.isOutdatedAppVersion {
                            seal.reject(UalaError.outdatedAppVersion)
                        } else {
                            seal.reject(error)
                        }
                    case .success(let credentials):
                        _ = self.credentialsManager.store(credentials: credentials)
                        seal.fulfill_()
                    }
            }
        }
    }
    
    private func getLoginParameters() -> [String: String] {
        let version = Bundle.main.infoDictionary?["CFBundleVersion"] ?? ""
        let parameters = [
            "device": UIDevice.current.identifierForVendor?.uuidString ?? "",
            "version": "ios|\(version)"
        ]
        return parameters
    }

    func signUp(email: String, password: String, username: String?) -> Promise<Void> {
        return Promise { seal in
            authentication
                .createUser(email: email,
                            username: username,
                            password: password,
                            connection: authConfig.database,
                            userMetadata: nil)
                .start {
                    switch $0 {
                    case .failure(let error):
                        seal.reject(error)
                    case .success:
                        seal.fulfill_()
                    }
            }
        }
    }
    
    func signOut() {
        _ = credentialsManager.clear()
    }
    
    func forgotPassword(username: String) -> Promise<Void> {
        return Promise {seal in
            authentication
                .resetPassword(email: username, connection: authConfig.database)
                .start {
                    switch $0 {
                    case .failure(let error):
                        seal.reject(error)
                    case .success:
                        seal.fulfill_()
                    }
            }
        }
    }
    
    func getUserInfo<T: Decodable>(mapper: T.Type) -> Promise<T> {
        return Promise<T> { seal in
            firstly {
                getAccessToken()
            }.done { token in
                self.authentication
                    .userInfo(token: token).start {
                        switch $0 {
                        case .failure(let error):
                            seal.reject(error)
                        case .success(let user):
                            do {
                                let dataInfo: Data = try JSONSerialization.data(withJSONObject: user.additionalAttributes)
                                let decoder: JSONDecoder = JSONDecoder()
                                decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.useDefaultKeys
                                let result: T = try decoder.decode(mapper.self, from: dataInfo)
                                seal.fulfill(result)
                            } catch _ as NSError {
                                seal.reject(UalaError.undefined)
                            }
                        }
                    }
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    private func renewAccessToken(refreshToken: String) -> Promise<Void> {
        return Promise { seal in
            authentication.renew(withRefreshToken: refreshToken,
                                 scope: "openid profile offline_access")
                .start {
                    switch $0 {
                    case .failure(let error):
                        guard let authError = error as? Auth0.AuthenticationError else {
                            seal.reject(UalaError.undefined)
                            return
                        }
                        if authError.isAccountNotVerified {
                            seal.reject(UalaError.accountNotVerified)
                        } else {
                            seal.reject(error)
                        }
                    case .success(let credentials):
                        let newCredentials = Auth0.Credentials(accessToken: credentials.accessToken,
                                                               tokenType: credentials.tokenType,
                                                               idToken: credentials.idToken,
                                                               refreshToken: credentials.refreshToken ?? refreshToken,
                                                               expiresIn: credentials.expiresIn,
                                                               scope: credentials.scope)
                        _ = self.credentialsManager.store(credentials: newCredentials)
                        seal.fulfill_()
                    }
            }
        }
    }
}

extension Auth: MFACredentials {
    func loginWithOOB(_ code: String) -> Promise<Void> {
        guard let oob = oob else { return Promise.init(error: UalaError.undefined) }
        return Promise<Void> { seal in
            firstly {
                getAccessToken()
            }.then { token -> Promise<Auth0.Credentials> in
                self.MFA.loginWithOOB(oob, code, token)
            }.done { credentials in
                _ = self.credentialsManager.store(credentials: credentials)
                seal.fulfill_()
            }.catch { error in
                seal.reject(error)
            }
        }
    }

    func associate(_ phone: String, by method: MFAMethod) -> Promise<Void> {
        return Promise<Void> { seal in
            MFA.associate(phone, by: method).done { oob in
                self.oob = oob
                seal.fulfill_()
            }.catch { error in
                seal.reject(error)
            }
        }
    }

    func challenge() -> Promise<Void> {
        return Promise<Void> { seal in
            firstly {
                getAccessToken()
            }.then { token -> Promise<String> in
                self.MFA.challenge(token)
            }.done { oob in
                self.oob = oob
                seal.fulfill_()
            }.catch { error in
                seal.reject(error)
            }
        }
    }
  
    func register(_ UUID: String) -> Promise<Void> {
      return Promise<Void> { seal in
        self.MFA.register(UUID).done { _ in
          seal.fulfill_()
        }.catch { error in
          seal.reject(error)
        }
      }
    }

    func loginEnroll(username: String, password: String) async throws -> String {
        return ""
    }
}
