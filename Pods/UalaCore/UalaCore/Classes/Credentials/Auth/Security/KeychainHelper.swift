//
//  KeychainHelper.swift
//  UalaCore
//
//  Created by Agustin Jaimes on 18/02/22.
//

import Foundation

final class KeychainHelper {

    public enum Service: String {
        case idToken
        case refreshToken
        case accessToken
        case mfaToken
        case username
    }

    static let standard = KeychainHelper()

    let defaults = UserDefaults.standard
    private init() {
        // Singleton implementation
    }

    func save(_ value: String, service: KeychainHelper.Service) {
        let keychainData = Data(value.utf8)
        defaults.set(keychainData, forKey: service.rawValue)
    }

    func read(service: KeychainHelper.Service) -> String {
        guard let data = defaults.data(forKey: service.rawValue),
              let value = String(data: data, encoding: .utf8) else { return "" }
        return value
    }

    func clearTokens() {
        save("", service: .accessToken)
        save("", service: .mfaToken)
        save("", service: .idToken)
        save("", service: .refreshToken)
        save("", service: .username)
    }
}
