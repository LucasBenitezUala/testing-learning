//
//  
//  LoginPresenter.swift
//  UalaAuth
//
//  Created by Andrés Abraham Bonilla Gómex on 19/10/21.
//  Copyright © 2021 Ualá. All rights reserved.
//
//

import UIKit
import UalaCore
import CoreLocation
import PromiseKit

public protocol LoginDemoPresenterEventsType: AnyObject {
    @MainActor
    func get(error: Error)
    @MainActor
    func loginSuccess(scheme: Scheme,
                      country: CountryEnvironment,
                      loginData: LoginData) async
}

internal final class LoginDemoPresenter: LoginDemoPresenterType {
    
    weak var view: LoginDemoViewType?
    private var country: CountryEnvironment = .Argentina
    private var scheme: Scheme = .stage
    private let interactor: LoginDemoInteractorType
    private let router: LoginDemoRouterType
    let presenterEvents: LoginDemoPresenterEventsType
    
    init(interactor: LoginDemoInteractorType,
         presenterEvents: LoginDemoPresenterEventsType,
         router: LoginDemoRouterType) {
        self.interactor = interactor
        self.presenterEvents = presenterEvents
        self.router = router
    }
    
    func doLogin(params: LoginParameters) {
        self.country = params.country
        self.scheme = params.scheme
        Task.detached { [weak self] in
            guard let self = self else { return }
            
            do {
                try await self.loading(true)
                try await self.interactor.setupEnvironment(scheme: params.scheme, country: params.country)
                try await self.interactor.login(username: params.loginData.username, password: params.loginData.password)
                await self.loginSuccess()
                try await self.loading(false)
            } catch {
                if let error = error as? UalaError, error == .MFARequired {
                    self.challenge()
                    return
                }
                await self.get(error: error)
                await self.show(message: error.localizedDescription)
                try await self.loading(false)
            }
        }
    }

    func challenge() {
        Task.detached {
            do {
                try await self.loading(true)
                try await self.interactor.challenge()
                try await self.loading(false)
                await self.showCaptureCode()
            } catch {
                await self.get(error: error)
                await self.show(message: error.localizedDescription)
                try await self.loading(false)
            }
        }
    }

    func doLoginMFA(with code: String) {
        Task.detached {
            do {
                try await self.loading(true)
                try await self.interactor.login(with: code)
                await self.loginSuccess()
                try await self.loading(false)
            } catch {
                await self.get(error: error)
                await self.show(message: error.localizedDescription)
                try await self.loading(false)
            }
        }
    }

    func setupEnvironment(scheme: Scheme, country: CountryEnvironment) async throws {
        self.country = country
        self.scheme = scheme
        try await interactor.setupEnvironment(scheme: scheme, country: country)
    }
    
    func fetchLoginData() -> LoginData? {
        return interactor.loadCredentials()
    }
        
    func show(message: String) async {
        await view?.show(message: message)
    }
    
    func loading(_ value: Bool) async throws {
        await view?.loading(value)
    }

    @MainActor
    func showCaptureCode() async {
        let alertController = await UIAlertController(title: "Auth MFA",
                                                      message: "Escribe el codigo que enviamos al num registrado",
                                                      preferredStyle: .alert)
        await alertController.addTextField()

        let enterCode = await UIAlertAction(title: "Acceder",
                                            style: .default) { [unowned alertController] _ in
            guard let code = alertController.textFields?[0].text else {
                return
            }
            self.doLoginMFA(with: code)
        }
        
        await alertController.addAction(enterCode)
        
        await view?.show(alert: alertController)
    }
    
    func loginSuccess() async {
        guard let loginData: LoginData = self.interactor.loadCredentials() else { return }
        do {
            try await self.presenterEvents.loginSuccess(scheme: self.scheme,
                                                        country: self.country,
                                                        loginData: loginData)
            await self.router.goNextScreen()
        } catch let error {
            await self.get(error: error)
            await self.show(message: error.localizedDescription)
        }
    }
    
    func get(error: Error) async {
        await presenterEvents.get(error: error)
        await show(message: error.localizedDescription)
    }
}
