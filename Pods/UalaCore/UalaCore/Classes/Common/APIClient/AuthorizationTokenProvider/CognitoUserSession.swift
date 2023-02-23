//
//  CognitoUserSession.swift
//  UalaCore
//
//  Created by Agustina Ardisana on 25/07/2022.
//

import AWSCognitoIdentityProvider

public struct CognitoUserSession {
    public let accessToken: String
    
    init(userSession: AWSCognitoIdentityUserSession) {
        self.accessToken = userSession.accessToken?.tokenString ?? ""
    }
    
    public init(accessToken: String = "") {
        self.accessToken = accessToken
    }
}
