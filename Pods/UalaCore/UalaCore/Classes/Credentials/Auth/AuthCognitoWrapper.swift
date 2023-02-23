//
//  AuthCognitoWrapper.swift
//  UalaCore
//
//  Created by Agustin Jaimes on 17/02/22.
//

import Foundation
import PromiseKit
import Auth0
import AWSCognito
import JWTDecode
import AWSCognitoIdentityProvider

public enum AuthWrapperError: Error {
    case invalidUserPool
    case bundleNotFound
    case notImplemented
}

final class AuthCognitoWrapper: Credentials {
    private let userPool: AWSCognitoIdentityUserPool
    private var authConfig: AuthConfig
    private var authentication: Authentication
    private var credentialsManager: CredentialsManager
    private var oob: String?
    private var mfaClient: MFAClient
    private var idleRefreshTokenTimer: Timer?
    private var keychain: AWSUICKeyChainStore?
    private var cognitoClientId: String
    private var timeoutInSeconds: TimeInterval {
        return 300
    }

    init() throws {

        let environment: Environment = CoreEnvironment.shared.environment
        authConfig = environment.authConfig
        mfaClient = MFAClient(config: authConfig)
        authentication = Auth0.authentication(clientId: authConfig.clientId, domain: authConfig.domain)
        credentialsManager = CredentialsManager(authentication: authentication)

        // Configure Cognito
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            throw AuthWrapperError.bundleNotFound
        }
        let keychainServiceName = bundleIdentifier + "." + String(describing: AWSCognitoIdentityUserPool.self)
        keychain = AWSUICKeyChainStore.init(service: keychainServiceName)

        let amazon: AmazonConfiguration = environment.amazon
        let configuration = AWSServiceConfiguration(region: amazon.region, credentialsProvider: nil)
        configuration?.timeoutIntervalForRequest = 120
        configuration?.timeoutIntervalForResource = 120

        AWSServiceManager.default()?.defaultServiceConfiguration = configuration

        let userPoolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: amazon.clientId,
                                                                            clientSecret: nil,
                                                                            poolId: amazon.userPoolId)
        AWSCognitoIdentityUserPool.register(with: nil,
                                            userPoolConfiguration: userPoolConfiguration,
                                            forKey: amazon.userPoolKey)

        guard let userpool = AWSCognitoIdentityUserPool(forKey: amazon.userPoolKey) else {
            throw AuthWrapperError.invalidUserPool
        }

        self.cognitoClientId = amazon.clientId
        self.userPool = userpool
    }

    deinit {
        idleRefreshTokenTimer?.invalidate()
        idleRefreshTokenTimer = nil
    }

    var isUserSignedIn: Bool {
        guard let currentUser = userPool.currentUser() else { return false }
        return currentUser.isSignedIn
    }

    func getToken() -> Promise<String> {
        guard let user = userPool.currentUser() else { return Promise(error: UalaError.unauthorized) }
        return Promise<String> { seal in
            user.getSession().continueWith { task -> Any? in
                if let error = task.error {
                    seal.reject(UalaError(error: error))
                } else {
                    if let session = task.result, let token = session.idToken {
                        seal.fulfill(token.tokenString)
                    } else {
                        seal.reject(UalaError.unauthorized)
                    }
                }
                return nil
            }
        }
    }

    func login(username: String, password: String) -> Promise<Void> {
        return authenticate(username: username, password: password, scope: .login)
    }

    fileprivate func authenticate(username: String, password: String, scope: LoginScope) -> Promise<Void> {
        let scopeType: String = scope == .login ? authConfig.defaultScope : authConfig.enrollScope
        return Promise { seal in
            
            let parameters: [String: String] = getLoginParameters()
            
            authentication
                .login(usernameOrEmail: username,
                       password: password,
                       realm: authConfig.database,
                       audience: authConfig.audience,
                       scope: scopeType,
                       parameters: parameters)
                .start { result in
                    KeychainHelper.standard.save(username, service: .username)
                    switch result {
                    case .failure(let error):
                        let error = self.processAuth0Error(error)
                        seal.reject(error)
                    case .success(let credentials):
                        if let token = credentials.accessToken {
                            self.processCredentials(with: username, token: token)
                        }
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

    fileprivate func processCredentials(with username: String, token: String) {
        guard let jwt = try? decode(jwt: token) else { return }

        let tokenClaim: String = jwt.claim(name: String.getConfigurationConstant(forKey: .tokenClaim)).string ?? ""
        let accessTokenClaim: String = jwt.claim(name: String.getConfigurationConstant(forKey: .accessTokenClaim)).string ?? ""
        let refreshTokenClaim: String = jwt.claim(name: String.getConfigurationConstant(forKey: .refreshTokenClaim)).string ?? ""

        let refreshTokenKeyChain = cognitoClientId + "." + username + ".refreshToken"
        let accessTokenKeyChain = cognitoClientId + "." + username + ".accessToken"
        let idTokenKeyChain = cognitoClientId + "." + username + ".idToken"
        let currentUserKeyChain = cognitoClientId + "." + "currentUser"

        keychain?.setString(refreshTokenClaim, forKey: refreshTokenKeyChain)
        keychain?.setString(accessTokenClaim, forKey: accessTokenKeyChain)
        keychain?.setString(tokenClaim, forKey: idTokenKeyChain)
        keychain?.setString(username, forKey: currentUserKeyChain)

        let expTokenKeyChain = cognitoClientId + "." + username + ".tokenExpiration"
        guard let cognitoJwt = try? decode(jwt: tokenClaim) else { return }

        var expiryInterval = cognitoJwt.claim(name: "exp").double
        var tokenExpiration = NSDate(timeIntervalSince1970: expiryInterval ?? 0)
        var expirationDateString = tokenExpiration .aws_stringValue(AWSDateISO8601DateFormat1)

        keychain?.setString(expirationDateString, forKey: expTokenKeyChain)
    }

    fileprivate func processAuth0Error(_ error: Error) -> Error {

        var ualaError: Error = UalaError.undefined

        guard let authError = error as? Auth0.AuthenticationError else {
            return ualaError
        }

        if authError.isAccountNotVerified {
            ualaError = UalaError.accountNotVerified
        } else if authError.isMultifactorRequired, let token = authError.info["mfa_token"] as? String {
            KeychainHelper.standard.save(token, service: .mfaToken)
            ualaError = UalaError.MFARequired
        } else if authError.secondLoginDenied {
            ualaError = UalaError.secondLoginRejected
        } else if authError.isAccountBlocked {
            ualaError = UalaError.accountBlocked
        } else if authError.isOutdatedAppVersion {
            ualaError = UalaError.outdatedAppVersion
        }

        return ualaError
    }

    func signUp(email: String, password: String, username: String?) -> Promise<Void> {
        return Promise<Void> { seal in
            let emailAttribute = AWSCognitoIdentityUserAttributeType(name: "email", value: email)
            let userAttributes = [emailAttribute]

            userPool.signUp(username ?? email, password: password, userAttributes: userAttributes, validationData: nil).continueWith { task -> Any? in
                if let error = task.error {
                    seal.reject(UalaError(error: error))
                } else {
                    seal.fulfill(())
                }
                return nil
            }
        }
    }

    func signOut() {
        _ = credentialsManager.clear()
        guard let currentUser = userPool.currentUser() else { return }
        currentUser.signOutAndClearLastKnownUser()
    }

    func getUserInfo<T>(mapper: T.Type) -> Promise<T> where T: Decodable {
        return Promise<T> { seal in
            seal.reject(UalaError(error: UalaError.unauthorized))
        }
    }

    func confirmCode(username: String, code: String) -> Promise<Void> {
        return Promise<Void> { seal in
            let user = userPool.getUser(username)
            user.confirmSignUp(code).continueWith { task -> Any? in
                if let error = task.error {
                    seal.reject(UalaError(error: error))
                } else {
                    seal.fulfill(())
                }
                return nil
            }
        }
    }
    
    func resendConfirmationCode(username: String) -> Promise<Void> {
        return Promise<Void> { seal in
            let user = userPool.getUser(username)
            user.resendConfirmationCode().continueWith { task -> Any? in
                if let error = task.error {
                    seal.reject(UalaError(error: error))
                } else {
                    seal.fulfill(())
                }
                return nil
            }
        }
    }
    
    func forgotPassword(username: String) -> Promise<Void> {
        return Promise<Void> { seal in
            let user = userPool.getUser(username)
            user.forgotPassword().continueWith { task -> Any? in
                if let error = task.error {
                    seal.reject(UalaError(error: error))
                } else {
                    seal.fulfill(())
                }
                return nil
            }
        }
    }

    func confirmForgotPassword(confirmationCode: String, username: String, password: String) -> Promise<Void> {
        return Promise<Void> { seal in
            let user = userPool.getUser(username)
            user.confirmForgotPassword(confirmationCode, password: password).continueWith { task -> Any? in
                if let error = task.error {
                    seal.reject(UalaError(error: error))
                } else {
                    seal.fulfill(())
                }
                return nil
            }
        }
    }

    func change(password: String, proposedPassword: String) -> Promise<Void> {
        guard let user = userPool.currentUser(), user.isSignedIn else {
            return Promise(error: UalaError.unauthorized)
        }
        return Promise<Void> { seal in
            user.changePassword(password, proposedPassword: proposedPassword).continueWith { task -> Any? in
                if let error = task.error as NSError? {
                    if error.code == AWSCognitoIdentityProviderErrorType.limitExceeded.rawValue {
                        seal.reject(UalaError.changePasswordLimit)
                        return nil
                    }
                    seal.reject(UalaError(error: error))
                } else {
                    seal.fulfill(())
                }
                return nil
            }
        }
    }

    func refreshAccessToken() -> Promise<Void> {
        return .init(error: UalaError.unauthorized)
    }
}

extension AuthCognitoWrapper: MFACredentials {
    func loginWithOOB(_ code: String) -> Promise<Void> {
        let mfaToken: String = KeychainHelper.standard.read(service: .mfaToken)
        let username: String = KeychainHelper.standard.read(service: .username)
        guard let oob = oob else { return Promise.init(error: UalaError.undefined) }
        return Promise<Void> { seal in
            firstly {
                mfaClient.loginWithOOB(with: mfaToken, oob: oob, code)
            }.done { credentials in
                self.processCredentials(with: username, token: credentials.accessToken ?? "")
                _ = self.credentialsManager.store(credentials: credentials)
                seal.fulfill_()
            }.catch { error in
                seal.reject(error)
            }
        }
    }

    func associate(_ phone: String, by method: MFAMethod) -> Promise<Void> {
        let mfaToken: String = KeychainHelper.standard.read(service: .mfaToken)
        return Promise<Void> { seal in
            mfaClient.associate(with: mfaToken, phone: phone, by: method).done { oob in
                self.oob = oob
                seal.fulfill_()
            }.catch { error in
                seal.reject(error)
            }
        }
    }

    func challenge() -> Promise<Void> {
        let mfaToken: String = KeychainHelper.standard.read(service: .mfaToken)
        return Promise<Void> { seal in
            firstly {
                mfaClient.challenge(with: mfaToken)
            }.done { oob in
                self.oob = oob
                seal.fulfill_()
            }.catch { error in
                seal.reject(error)
            }
        }
    }

    func register(_ UUID: String) -> Promise<Void> {
        return .init(error: UalaError.unauthorized)
    }

    func loginEnroll(username: String, password: String) async throws -> String {
        return try await withCheckedThrowingContinuation({ continuation in
            let parameters: [String: String] = getLoginParameters()
            authentication
                .login(usernameOrEmail: username,
                       password: password,
                       realm: authConfig.database,
                       audience: authConfig.enrollAudience,
                       scope: authConfig.enrollScope,
                       parameters: parameters)
                .start { result in
                    switch result {
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    case .success(let credentials):
                        guard let accessToken = credentials.accessToken else {
                            continuation.resume(throwing: "")
                            return
                        }
                        continuation.resume(returning: accessToken)
                    }
                }
        })
    }
}
