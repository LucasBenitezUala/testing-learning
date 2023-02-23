//
//  LoginDemoEntitties.swift
//  UalaAuth
//
//  Created by Francisco Javier Saldivar Rubio on 21/05/22.
//

import UalaCore

public struct LoginData: Codable {

    public let username: String
    public let password: String
}

public struct LoginParameters {

    var loginData: LoginData
    var scheme: Scheme
    var country: CountryEnvironment
}
