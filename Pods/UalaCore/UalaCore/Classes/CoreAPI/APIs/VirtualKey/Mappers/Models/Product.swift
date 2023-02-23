//
//  Product.swift
//  UalaCore
//
//  Created by Uala on 24/08/21.
//

import Foundation

public struct Product {
    public let productType: ProductType
    public let productStatus: ProductStatus
    public let productNumber: String
    public let baseProduct: Bool
    public let cardNumber: String
    public let cardId: String
    public let pmtRefNo: String
    public let galileoAccountNumber: String
}

public enum ProductType: String, Codable {
    case savingsAccount = "SAVINGS_ACCOUNT"
    case card = "CARD"
    case unknown
    
    public init(safeRawValue: String) {
        self = ProductType(rawValue: safeRawValue) ?? .unknown
    }
}

public enum ProductStatus: String, Codable {
    case active = "ACTIVE"
    case created = "CREATED"
    case error = "ERROR"
    case blocked = "BLOCKED"
    case temporalBlocked = "TEMPORAL_BLOCKED"
    case deleted = "DELETED"
    case pendingActivation = "PENDING_ACTIVATION"

    public init(safeRawValue: String) {
        self = ProductStatus(rawValue: safeRawValue) ?? .error
    }
}
