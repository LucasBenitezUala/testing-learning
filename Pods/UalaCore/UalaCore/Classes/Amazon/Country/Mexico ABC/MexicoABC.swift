//
//  MexicoABC.swift
//  UalaCore
//
//  Created by Luis Perez on 19/10/21.
//

public class MexicoABC: Environment {
    public var name: String = "MexicoABC"
    public var id = "MXABC"
    public lazy var credentials: Credentials = Auth()
    public var coreAPI: API = API(MexicoABCAPIManager())
    public var amazon: AmazonConfiguration = DefaultAmazonConfiguration()
    public var localeIdentifier = "es_MX"
    public let currencyCode = "MXN"
}
