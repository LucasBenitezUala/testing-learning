//
//  UserManagementAPIManager.swift
//  UalaCore
//
//  Created by Ualá on 04/08/21.
//

import Foundation

protocol UserManagementAPIManager {
    var userManagementRoutable: UserManagementRoutable { get set }
}

struct UserManagementManager: UserManagementAPIManager {
    public init() { }
    public var userManagementRoutable: UserManagementRoutable = UserManagementRouter()
}

struct UserManagementAPI {
    private var API: UserManagementAPIManager
    
    public init(_ API: UserManagementAPIManager) {
        self.API = API
    }
}

extension UserManagementAPI {
    mutating func userManagementAPI(route: UserManagementRoute) -> Routeable {
        API.userManagementRoutable.route = route
        return API.userManagementRoutable
    }
}
