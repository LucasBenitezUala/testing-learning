//
//  ArgentinaBank.swift
//  UalaCore
//
//  Created by Uala on 24/03/22.
//

public class ArgentinaBank: Environment {
    public let name: String = CountryEnvironment.ArgentinaBank.rawValue
    public var id = "AR"
    public lazy var credentials: Credentials = Auth()
    public var coreAPI: API = API(ColombiaAPIManager())
    public var amazon: AmazonConfiguration = DefaultAmazonConfiguration()
    public let localeIdentifier: String = "es_AR"
    public let currencyCode = "ARS"
    
    public init() {}
}
