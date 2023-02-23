//
//  ConfigurationConstantsKey.swift
//  UalaCore
//
//  Created by Laura Krayacich on 03/05/2021.
//

import Foundation

public protocol ConfigurationConstantsKeyType {
    var constantKey: String { get }
}

public enum ConfigurationConstantsKey: String, ConfigurationConstantsKeyType {
    // Test
    case testConstant = "TEST_CONSTANT"

    // Cognito Tokens
    case tokenClaim = "COGNITO_TOKEN_CLAIM"
    case accessTokenClaim = "COGNITO_ACCESS_TOKEN_CLAIM"
    case refreshTokenClaim = "COGNITO_REFRESH_TOKEN_CLAIM"
    case phoneVerifiedClaim = "phone_number_verified"
    case internationalDialPrefix = "INTERNATIONAL_DIAL_PREFIX"
    case internationalDialCode = "INTERNATIONAL_DIAL_CODE"

    public var constantKey: String {
        return self.rawValue
    }
}
