//
//  UpdateProfileMfaAPIManager.swift
//  UalaCore
//
//  Created by Ualá on 29/08/21.
//

import Foundation

protocol UpdateProfileMfaAPIManager {
    var updateProfileMFARoutable: UpdateProfileMFARoutable { get set }
}

struct UpdateProfileMFAManager: UpdateProfileMfaAPIManager {
    public init() { }
    public var updateProfileMFARoutable: UpdateProfileMFARoutable = UpdateProfileMFARouter()
}

struct UpdateProfileMFAAPI {
    private var API: UpdateProfileMFAManager
    
    public init(_ API: UpdateProfileMFAManager) {
        self.API = API
    }
}

extension UpdateProfileMFAAPI {
    mutating func userManagementAPI(route: UpdateProfileMFARoute) -> Routeable {
        API.updateProfileMFARoutable.route = route
        return API.updateProfileMFARoutable
    }
}
