//
//  UserManagementRoute.swift
//  UalaCore
//
//  Created by Ualá on 04/08/21.
//

import Foundation
import Alamofire

public enum UserManagementRoute {
    case addBeneficiary(String, String, String, String, Int, String, String)
    case getBeneficiariesList
    case deleteBeneficiary(String, String, String)
}

public protocol UserManagementRoutable: Routeable {
    var route: UserManagementRoute { get set }
}

extension UserManagementRoutable {

    public var method: HTTPMethod {
        .post
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
