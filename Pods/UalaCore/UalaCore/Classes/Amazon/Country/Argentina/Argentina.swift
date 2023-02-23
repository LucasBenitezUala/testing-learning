//
//  AWSCognitoType.swift
//  UalaCore
//
//  Created by Ignacio Gómez on 14/04/20.
//

public class Argentina: Environment {
    
    public let name: String = CountryEnvironment.Argentina.rawValue
    public let id: String = "AR"
    public lazy var credentials: Credentials = {
        do {
            return try AuthCognitoWrapper()
        } catch {
            return DefaultCredentials()
        }
    }()
    public var coreAPI: API = API(ArgentinaAPIManager())
    public var amazon: AmazonConfiguration = DefaultAmazonConfiguration()
    public let localeIdentifier: String = "es_AR"
    public let currencyCode = "ARS"
    
    public init() {}
}
