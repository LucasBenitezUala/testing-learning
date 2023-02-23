//
//  APIClientAuthorizationType.swift
//  UalaCore
//
//  Created by Luis Perez on 05/04/22.
//

public enum APIClientAuthorizationType {
    case bearerToken
    case authorization
    case none
    
    func authorizationHeader(token: String) -> [String: String] {
        switch self {
        case .bearerToken:
            return ["Authorization": "Bearer \(token)"]
        case .authorization:
            return ["Authorization": token]
        case .none:
            return [:]
        }
    }
}
