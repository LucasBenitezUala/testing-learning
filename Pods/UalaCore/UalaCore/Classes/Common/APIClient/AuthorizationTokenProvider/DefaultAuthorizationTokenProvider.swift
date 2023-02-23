//
//  DefaultAuthorizationTokenProvider.swift
//  UalaCore
//
//  Created by Luis Perez on 30/03/22.
//

final class DefaultAuthorizationTokenProvider: AuthorizationTokenProvider {
    func authorizationToken() async throws -> String {
        throw UalaError.undefined
    }
}
