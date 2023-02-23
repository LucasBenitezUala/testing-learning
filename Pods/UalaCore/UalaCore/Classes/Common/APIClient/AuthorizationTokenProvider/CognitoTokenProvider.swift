//
//  CognitoTokenProvider.swift
//  UalaCore
//
//  Created by Luis Perez on 30/03/22.
//

import AWSCognitoIdentityProvider

final class CognitoTokenProvider: AuthorizationTokenProvider {

    private let userPool: AWSCognitoIdentityUserPool

    init?(configuration: AmazonConfiguration,
         timeoutIntervalForRequest: TimeInterval,
         timeoutIntervalForResource: TimeInterval) {
        let serviceConfiguration = AWSServiceConfiguration(region: configuration.region,
                                                           credentialsProvider: nil)

        serviceConfiguration?.timeoutIntervalForRequest = timeoutIntervalForRequest
        serviceConfiguration?.timeoutIntervalForResource = timeoutIntervalForResource

        AWSServiceManager.default().defaultServiceConfiguration = serviceConfiguration

        let userPoolConfigiration = AWSCognitoIdentityUserPoolConfiguration(clientId: configuration.clientId,
                                                                            clientSecret: nil,
                                                                            poolId: configuration.userPoolId)

        AWSCognitoIdentityUserPool.register(with: nil,
                                            userPoolConfiguration: userPoolConfigiration,
                                            forKey: configuration.userPoolKey)

        guard let userPool = AWSCognitoIdentityUserPool(forKey: configuration.userPoolKey) else {
            return nil
        }

        self.userPool = userPool
    }

    public func authorizationToken() async throws -> String {
        guard let user = userPool.currentUser() else {
            throw UalaError.unauthorized
        }
        return try await authorizationToken(for: user)
    }
    
    public func cognitoUserSession() async throws -> CognitoUserSession {
        guard let user = userPool.currentUser() else {
            throw UalaError.unauthorized
        }
        return try await getCognitoUserSession(for: user)
    }

    private func authorizationToken(for user: AWSCognitoIdentityUser) async throws -> String {
        return try await withCheckedThrowingContinuation({ continuation in
            user.getSession().continueWith { task in
                if let userSession = task.result,
                   let authorizationToken = userSession.idToken {
                    continuation.resume(returning: authorizationToken.tokenString)
                } else {
                    continuation.resume(throwing: UalaError(error: task.error ?? UalaError.unauthorized))
                }
                return nil
            }
        })
    }
    
    private func getCognitoUserSession(for user: AWSCognitoIdentityUser) async throws -> CognitoUserSession {
        return try await withCheckedThrowingContinuation({ continuation in
            user.getSession().continueWith { task in
                if let userSession = task.result {
                    let cognitoUserSession = CognitoUserSession(userSession: userSession)
                    continuation.resume(returning: cognitoUserSession)
                } else {
                    continuation.resume(throwing: UalaError(error: task.error ?? UalaError.unauthorized))
                }
                return nil
            }
        })
    }
}
