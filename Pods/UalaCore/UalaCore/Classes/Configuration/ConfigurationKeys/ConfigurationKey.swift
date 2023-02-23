//
//  ConfigurationKey.swift
//  UalaCore
//
//  Created by Laura Krayacich on 03/05/2021.
//

import Foundation

public protocol ConfigurationKeyImpl { }

public struct ConfigurationKey: ConfigurationKeyImpl {
    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    // MARK: Test
    static let testConfigurationKey = ConfigurationKey(rawValue: "TEST_CONFIG_KEY")

    // MARK: AuthConfig
    static let authConfigDatabase = ConfigurationKey(rawValue: "AUTHCONFIG_DATABASE")
    static let authConfigDomain = ConfigurationKey(rawValue: "AUTHCONFIG_DOMAIN")
    static let authConfigAudience = ConfigurationKey(rawValue: "AUTHCONFIG_AUDIENCE")
    static let authConfigClientId = ConfigurationKey(rawValue: "AUTHCONFIG_CLIENT_ID")
    static let authConfigDefaultScope = ConfigurationKey(rawValue: "AUTHCONFIG_DEFAULT_SCOPE")
    static let authConfigEnrollScope = ConfigurationKey(rawValue: "AUTHCONFIG_ENROLL_SCOPE")
    static let authConfigEnrollAudience = ConfigurationKey(rawValue: "AUTHCONFIG_ENROLL_AUDIENCE")
    static let baseUrlDeviceId = ConfigurationKey(rawValue: "DEVICE_ID_BASE_URL")

    // MARK: AuthConfig MFA
    static let mfaBaseURL = ConfigurationKey(rawValue: "MFA_API_BASE_URL")
    static let mfaGrantType = ConfigurationKey(rawValue: "MFA_GRANT_TYPE")
    static let mfaSendPath = ConfigurationKey(rawValue: "MFA_SEND_EMAIL_PATH")
    static let mfaVerifyPath = ConfigurationKey(rawValue: "MFA_VERIFY_EMAIL_PATH")
    static let obtainPhonePath = ConfigurationKey(rawValue: "PHONE_REQUEST_PATH")
    static let userInfoPath = ConfigurationKey(rawValue: "USER_INFO_PATH")
    
    // MARK: AmazonConfig
    static let amazonUserpoolId = ConfigurationKey(rawValue: "AMAZON_USERPOOL_ID")
    static let amazonClientId = ConfigurationKey(rawValue: "AMAZON_CLIENT_ID")
    static let amazonIdentityPoolId = ConfigurationKey(rawValue: "AMAZON_IDENTITY_POOL_ID")
    static let amazonS3BucketName = ConfigurationKey(rawValue: "S3_BUCKET_NAME")

    public static let baseUrlDebit = ConfigurationKey(rawValue: "BASE_URL_DEBIT")
    public static let baseUrlFreezeCol = ConfigurationKey(rawValue: "BASE_URL_FREEZE")
    public static let baseUrlCard = ConfigurationKey(rawValue: "BASE_URL_CARD_DEBIT")
    public static let baseUrlSignUp = ConfigurationKey(rawValue: "BASE_URL_SIGN_UP")
    public static let baseUrlRegistration = ConfigurationKey(rawValue: "BASE_URL_REGISTRATION")
    public static let baseUrlTransactionsDetail = ConfigurationKey(rawValue: "BASE_URL_TRANSACTIONS_DETAIL")
    public static let baseUrlCardBFF = ConfigurationKey(rawValue: "BASE_URL_CARD_BFF")

    // MARK: USER MANAGEMENT
    public static let userManagementURL = ConfigurationKey(rawValue: "MANAGEMENT_URL_API")
    
    // MARK: TaxCalculator
    public static let baseUrlDollarTaxes = ConfigurationKey(rawValue: "BASE_URL_DOLLAR_TAX")
    
    // MARK: REMITTANCES
    public static let remittancesURL = ConfigurationKey(rawValue: "REMITTANCES_URL_API")
    
    // MARK: ACQUIRING ACCOUNT PPJJ
    public static let acquiringMiddleURL = ConfigurationKey(rawValue: "ACQUIRING_MIDDLE_URL_API")
    public static let acquiringMiddleAccountPath = ConfigurationKey(rawValue: "ACQUIRING_MIDDLE_ACCOUNT_PATH")
    public static let acquiringMiddleRefundPath = ConfigurationKey(rawValue: "ACQUIRING_MIDDLE_REFUND_PATH")

    // MARK: TRANSFER LIMIT
    public static let transferLimitApiKey = ConfigurationKey(rawValue: "TRANSFER_LIMIT_API_KEY")
    
    // MARK: ABC Base url
    public static let abcBaseUrl = ConfigurationKey(rawValue: "BASE_URL_ABC_UALA")
    
    // MARK: Card Tracking
    public static let trackingeBaseUrl = ConfigurationKey(rawValue: "BASE_URL_TRACKING_BFF")
    
    // MARK: BFF
    public static let bffUserBaseUrl = ConfigurationKey(rawValue: "BASE_URL_USER_BFF")
    public static let bffOnboarding = ConfigurationKey(rawValue: "BFF_ONBOARDING")
    public static let bffPostlogin = ConfigurationKey(rawValue: "BFF_POSTLOGIN")
    
    // MARK: CASHOUT
    public static let cashoutBaseUrl = ConfigurationKey(rawValue: "CASHOUT_BASE_PATH")
}
