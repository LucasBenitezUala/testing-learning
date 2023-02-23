//
//  LoginStatus.swift
//  LoginExample
//
//  Created by Francisco Javier Saldivar Rubio on 29/10/22.
//

public protocol LoginStatus {
    func setLoginStatus(isLogged: Bool)
    func getLoginStatus() -> Bool
}

public final class LoginStatusDefault: LoginStatus {
    static var isLogged: Bool = false

    public func getLoginStatus() -> Bool {
        Self.isLogged
    }

    public func setLoginStatus(isLogged: Bool) {
        Self.isLogged = isLogged
    }
}
