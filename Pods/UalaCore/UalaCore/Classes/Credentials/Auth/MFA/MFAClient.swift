import Auth0
import PromiseKit

class MFAClient: BaseRepository {

    var router: MFARouter
    var baseApiManager: BaseApiManager

    init(config: AuthConfig) {
        router = MFARouter(config.clientId, config.domain, config.baseUrlDeviceId)
        baseApiManager = BaseApiManager()
    }

    func challenge(_ token: String) -> Promise<String> {
        router.route = .challenge(token: token)
        return requestAuth(router)
    }

    func challenge(with token: String) -> Promise<String> {
        router.route = .challenge(token: token)
        return request(router)
    }

    func loginWithOOB(_ oob: String, _ code: String, _ token: String) -> Promise<Auth0.Credentials> {
        router.route = .login(token: token, oob: oob, code: code)
        return requestAuth(router)
    }

    func loginWithOOB(with mfaToken: String, oob: String, _ code: String) -> Promise<Auth0.Credentials> {
        router.route = .login(token: mfaToken, oob: oob, code: code)
        return request(router)
    }

    func associate(_ phone: String, by method: MFAMethod) -> Promise<String> {
        router.route = .associate(phone: phone, method: method.rawValue)
        return self.requestAuth(router)
    }

    func associate(with mfaToken: String, phone: String, by method: MFAMethod) -> Promise<String> {
        router.route = .associate(phone: phone, method: method.rawValue, mfaToken: mfaToken)
        return self.request(router)
    }
  
    func register(_ UUID: String) -> Promise<Void> {
        router.route = .register(UUID: UUID)
        let body: [String: String] = ["deviceId": UUID]
        return baseApiManager.requestAuth(router, body: body).then { (_: Int) -> Promise<Void> in
            return Promise<Void> { seafil in
                seafil.fulfill_()
            }
        }
    }
}
