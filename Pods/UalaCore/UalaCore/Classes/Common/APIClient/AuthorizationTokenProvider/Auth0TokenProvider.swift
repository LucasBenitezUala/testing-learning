//
//  Auth0TokenProvider.swift
//  UalaCore
//
//  Created by Luis Perez on 30/03/22.
//

import Auth0

final class Auth0TokenProvider: AuthorizationTokenProvider {
    private let authentication: Authentication
    private let credentialsManager: CredentialsManager

    init(configuration: AuthConfig) {
        self.authentication = Auth0.authentication(clientId: configuration.clientId,
                                                   domain: configuration.domain)
        self.credentialsManager = CredentialsManager(authentication: self.authentication)
    }

    convenience init() {
        self.init(configuration: AuthConfig())
    }

    public func authorizationToken() async throws -> String {
        return try await getAccessToken()
    }

    private func getAccessToken() async throws -> String {
        return try await withCheckedThrowingContinuation({ continuation in
            credentialsManager.credentials { error, credentials in
                if let token = credentials?.accessToken {
                    continuation.resume(returning: token)
                } else if let error = error, error.isInusualBehaviour {
                    continuation.resume(throwing: UalaError.auth0InusualActivity)
                } else {
                    continuation.resume(throwing: UalaError.undefined)
                }
            }
        })
    }
}
