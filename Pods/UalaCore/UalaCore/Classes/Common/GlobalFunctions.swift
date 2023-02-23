//
//  GlobalFunctions.swift
//  Uala
//
//  Created by Nelson Domínguez on 13/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name
public enum StringTables: String {
    case Common, Core, Investments, Loans, PinFlow, Transactions, SignUp,
         Exchange, AccountCharge, Transfers, Acquiring, UalaHelp, Cards,
         Loyalty, Portfolio, Taxes, Crypto, Remittances, Insurance,
         UalaSoftoken, Cedears, Tracking, Payments, CreditCard, Accounts
}

public func translate(_ key: String, from table: StringTables? = nil) -> String {
    let bundle = BundleUtils.getBundle(from: table)
    let tableName = table?.rawValue ?? "Localizable"
    let environment: Environment = CoreEnvironment.shared.environment
    var value = NSLocalizedString(key, tableName: tableName, bundle: bundle, value: "", comment: "")
    if environment is MexicoABC {
        value = NSLocalizedString(key, tableName: tableName + "-\(Mexico().id)", bundle: bundle, value: value, comment: "")
    }
    return NSLocalizedString(key, tableName: tableName + "-\(environment.id)", bundle: bundle, value: value, comment: "")
}

public func optionalStringValidator(_ text: String?) -> String {
    if let text = text {
        return text
    }
    return ""
}

public func getUUID() -> [String: String] {
    let deviceKey = "device"
    var parameter: [String: String] = [:]
    
    if let uuid = UIDevice.current.identifierForVendor?.uuidString {
        parameter = [deviceKey: uuid]
    }
    
    return parameter
}
