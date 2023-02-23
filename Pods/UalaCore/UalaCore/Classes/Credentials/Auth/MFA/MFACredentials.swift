import PromiseKit

public protocol MFACredentials {
    func challenge() -> Promise<Void>
    func associate(_ phone: String, by method: MFAMethod) -> Promise<Void>
    func loginWithOOB(_ code: String) -> Promise<Void>
    func register(_ UUID: String) -> Promise<Void>
    func loginEnroll(username: String, password: String) async throws -> String
}
