//
//  AWSCognitoType.swift
//  UalaCore
//
//  Created by Ignacio Gómez on 30/03/20.
//

import Foundation

public protocol Environment {
    var id: String { get }
    var coreAPI: API { get set }
    var amazon: AmazonConfiguration { get set }
    var credentials: Credentials { get set }
    var name: String { get }
    var localeIdentifier: String { get }
    var currencyCode: String { get }
}

// TODO: Fix cases to compy with `Enum element name should start with a lowercase character`
// swiftlint:disable identifier_name
public enum CountryEnvironment: String, CaseIterable {
    case Argentina, Mexico, Colombia, MexicoABC, ArgentinaBank
}

public struct EnvironmentBuilder {
    
    public static func create(_ scheme: Scheme,
                              _ country: CountryEnvironment = .Argentina) -> Environment {
        
        var environment: Environment
        
        switch country {
        case .Mexico:
            environment = Mexico()
        case .Argentina:
            environment = Argentina()
        case .Colombia:
            environment = Colombia()
        case .MexicoABC: 
            environment = MexicoABC()
        case .ArgentinaBank:
            environment = ArgentinaBank()
        }
        
        environment.amazon.scheme = scheme
        return environment
    }
}
