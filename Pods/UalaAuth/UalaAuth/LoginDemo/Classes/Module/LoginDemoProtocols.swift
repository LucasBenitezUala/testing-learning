//
//  
//  LoginFactory+Dependencies.swift
//  UalaAuth
//
//  Created by Andrés Abraham Bonilla Gómex on 19/10/21.
//  Copyright © 2021 Ualá. All rights reserved.
//
//

import UIKit
import UalaCore
import PromiseKit

public protocol LoginDemoViewType: UIViewController {
    var presenter: LoginDemoPresenterType? { get set }
    
    @MainActor
    func show(message: String)
    @MainActor
    func loading(_ value: Bool)
    @MainActor
    func show(alert: UIAlertController)
}

public protocol LoginDemoPresenterType {
    var view: LoginDemoViewType? { get set }
    var presenterEvents: LoginDemoPresenterEventsType { get }
    func doLogin(params: LoginParameters)
    func fetchLoginData() -> LoginData?
    func challenge()
    func doLoginMFA(with code: String)
}

public protocol LoginDemoInteractorType {
    var dependencies: LoginDemoInteractorDependenciesType { get }
    func setupEnvironment(scheme: Scheme, country: CountryEnvironment) async throws
    func login(username: String, password: String) async throws
    func loadCredentials() -> LoginData?
    func saveCredentials(credentials: LoginData?)
    func challenge() async throws
    func login(with oob: String) async throws
}

public protocol LoginDemoRouterType: AnyObject {
    var view: LoginDemoViewType? { get set }
    
    @MainActor
    func goNextScreen()
}

public protocol LoginDemoInteractorDependenciesType {
    var userDefaults: UserDefaults { get }
    var credentialsKey: String { get }
}

struct LoginDemoInteractorDependencies: LoginDemoInteractorDependenciesType {

    var userDefaults: UserDefaults { .standard }
    var credentialsKey: String { "credentials" }
}
