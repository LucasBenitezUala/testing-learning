//
//  File.swift
//  LoginExample
//
//  Created by Francisco Javier Saldivar Rubio on 29/10/22.
//

import UalaAuth
import UalaUtils
import UalaCore

final class LoginEvents: LoginDemoPresenterEventsType {
    private let loginStatus: LoginStatus
    private let logManager: LogManager
    
    init(loginStatus: LoginStatus = LoginStatusDefault(), logManager: LogManager = LogManager.shared) {
        self.loginStatus = loginStatus
        self.logManager = logManager
    }

    func get(error: Error) {
        self.logManager.debugError(error: error, type: self)
    }
    
    func loginSuccess(scheme: Scheme, country: CountryEnvironment, loginData: LoginData) async {
        self.logManager.debug(info: "Sheme -> \(scheme.rawValue)")
        self.logManager.debug(info: "Country -> \(country.rawValue)")
        loginStatus.setLoginStatus(isLogged: true)
    }
}

