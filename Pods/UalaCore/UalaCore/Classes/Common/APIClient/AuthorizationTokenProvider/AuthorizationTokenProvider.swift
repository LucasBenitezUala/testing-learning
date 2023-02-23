//
//  AuthorizationTokenProvider.swift
//  UalaCore
//
//  Created by Luis Perez on 07/04/22.
//

public protocol AuthorizationTokenProvider: AnyObject {
    func authorizationToken() async throws -> String
    func cognitoUserSession() async throws -> CognitoUserSession
}

public extension AuthorizationTokenProvider {
    func cognitoUserSession() async throws -> CognitoUserSession {
        return CognitoUserSession()
    }
}
