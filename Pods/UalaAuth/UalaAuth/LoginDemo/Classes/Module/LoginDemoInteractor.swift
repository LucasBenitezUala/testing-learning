//
//  LoginDemoInteractor.swift
//  UalaAuth
//
//  Created by Andrés Abraham Bonilla Gómex on 19/10/21.
//  Copyright © 2021 Ualá. All rights reserved.
//

import UalaUtils
import UalaCore
import PromiseKit
import UalaAuth

internal final class LoginDemoInteractor: LoginDemoInteractorType {
    
    let dependencies: LoginDemoInteractorDependenciesType
    private var environment: Environment?
    internal var credentials: LoginData?

    init(dependencies: LoginDemoInteractorDependenciesType) {
        self.dependencies = dependencies
    }
    
    func setupEnvironment(scheme: Scheme, country: CountryEnvironment) async throws {
        environment = EnvironmentBuilder.create(scheme, country)
        if let validEnvironment: Environment = environment {
            CoreStarter.start(environment: validEnvironment)
        } else {
            let environmentError: Error = "No se pudo crear el ambiente"
            throw environmentError
        }
    }
    
    func login(username: String, password: String) async throws {

        guard let environment = environment else {
            let environmentError: Error = "No hay ambiente seteado"

            throw environmentError
        }

        credentials = LoginData(username: username, password: password)

        return try await withUnsafeThrowingContinuation { continuation in
        environment.credentials.login(username: username, password: password)
            .done { [weak self] _ in
                self?.saveCredentials(credentials: self?.credentials)
                continuation.resume(with: .success(result: ()))
            }.catch { error in
                continuation.resume(with: .failure(error: error))
            }
        }
    }
    
    func loadCredentials() -> LoginData? {
        
        guard let credentialsData = dependencies.userDefaults.object(forKey: dependencies.credentialsKey) as? Data else {
            return nil
        }
        return try? JSONDecoder().decode(LoginData.self, from: credentialsData)
    }
    
    func saveCredentials(credentials: LoginData?) {
        guard let credentialsData = try? JSONEncoder().encode(credentials) else {
            return
        }
        dependencies.userDefaults.set(credentialsData, forKey: dependencies.credentialsKey)
    }

    func challenge() async throws {
        guard let credentials: MFACredentials = environment?.credentials as? MFACredentials else {
            let credentialsError: Error = "No existen MFACredentials"
            throw credentialsError
        }

        return try await withUnsafeThrowingContinuation { continuation in
            credentials.challenge().done { _ in
                continuation.resume(with: .success(()))
            }.catch { error in
                continuation.resume(with: .failure(error: error))
            }
        }
    }

    func login(with oob: String) async throws {
        guard let credentials: MFACredentials = environment?.credentials as? MFACredentials else {
            let credentialsError: Error = "No existen MFACredentials"
            throw credentialsError
        }

        return try await withUnsafeThrowingContinuation { continuation in
            credentials.loginWithOOB(oob).done { [weak self] _ in
                self?.saveCredentials(credentials: self?.credentials)
                continuation.resume(with: .success(()))
            }.catch { error in
                continuation.resume(with: .failure(error: error))
            }
        }
    }
}
