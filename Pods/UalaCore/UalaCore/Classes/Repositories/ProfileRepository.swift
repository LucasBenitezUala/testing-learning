import Foundation
import PromiseKit
import Alamofire

public class ProfileRepository {
            
    private var baseAPIManager: BaseApiManager {
        return ServiceLocator.inject()
    }

    public init() { }
    
    public func details() -> Promise<User> {
        let environment: Environment = CoreEnvironment.shared.environment
        guard let profileRepository = environment as? ProfileRepositoyDependenciesProtocol else { return .init(error: UalaError.undefined) }
        return profileRepository.details()
    }
    
    public func balance() -> Promise<Balance> {
        return Promise<Balance> { seal in
            baseAPIManager.requestApi1(path: "balance", method: .get).done { result in
                guard let balance = try? JSONDecoder().decode(Balance.self,
                                                              from: result["balance"].rawData()) else {
                    seal.reject(UalaError.undefined)
                    return
                }

                UserSessionData.balance = balance
                seal.fulfill(balance)
                }.catch({ error in
                    seal.reject(error)
                })
        }
    }
    
    public func verify(securityCode: String) -> Promise<Bool> {
        return Promise<Bool> { seal in
            let parameters = ["pin": securityCode]            
            baseAPIManager.requestApi1(path: "accounts/pin/validate",
                                       method: .post,
                                       parameters: parameters,
                                       encoding: JSONEncoding.default).done { result in
                                        seal.fulfill(result["valid"].boolValue)
                }.catch({ error in
                    seal.reject(error)
                })
        }
    }
}
