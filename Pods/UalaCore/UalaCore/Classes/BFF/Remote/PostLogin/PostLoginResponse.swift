//
//  PostLoginResponse.swift
//  UalaCore
//
//  Created by Andrés Abraham Bonilla Gómex on 12/01/22.
//  Copyright © 2022 Ualá. All rights reserved.
//

import Foundation

struct PostLoginResponse: Decodable {
    
    let userInfo: PostLoginUserInfoResponse?
    let userAction: PostLoginUserActionResponse?
}

struct PostLoginUserInfoResponse: Decodable {
    
    let name: String?
    let lastName: String?
    let displayName: String?
    let avatar: String?
    let userType: String?
    let id: String?
    let status: String?
    let email: String?
    let username: String?
    let phoneNumber: String?
    let hasTransactionalPin: Bool?
}

struct PostLoginUserActionResponse: Decodable {
    
    let type: String?
    let link: String?
}
