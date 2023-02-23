//
//  ProfileRepositoyDependencies.swift
//  Alamofire
//
//  Created by Enzo Digiano on 27/10/2020.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON

typealias ProfileRequest = () -> Promise<JSON>

protocol ProfileRepositoyDependenciesProtocol {
    var profileRequest: ProfileRequest { get }
    func details() -> Promise<User>
}

extension ProfileRepositoyDependenciesProtocol {
    
    var profileRequest: ProfileRequest {
        return {
            BaseApiManager().requestApi1(path: "user", method: .get)
        }
    }
    
    func details() -> Promise<User> {
        return Promise<User> { seal in
            profileRequest().done { result in
                guard let userResponse = try? JSONDecoder().decode(RemoteUser.User.self, from: result.rawData()) else {
                    seal.reject(UalaError.undefined)
                    return
                }
                
                let user = UserMapper.map(from: userResponse)
                UserSessionData.user = user
                seal.fulfill(user)
            }.catch({ error in
                seal.reject(error)
            })
        }
    }
}

extension Argentina: ProfileRepositoyDependenciesProtocol {
    var profileRequest: ProfileRequest {
        return {
            BaseApiManager().requestApi2(path: "users", method: .get)
        }
    }
}

extension Mexico: ProfileRepositoyDependenciesProtocol { }
extension MexicoABC: ProfileRepositoyDependenciesProtocol { }
extension Colombia: ProfileRepositoyDependenciesProtocol {
    var profileRequest: ProfileRequest {
        return {
            BaseApiManager().requestApi1(path: "users", method: .get)
        }
    }
}

extension ArgentinaBank: ProfileRepositoyDependenciesProtocol {
    var profileRequest: ProfileRequest {
        return {
            BaseApiManager().requestApi1(path: "users", method: .get)
        }
    }
}
