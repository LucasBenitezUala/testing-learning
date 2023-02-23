//
//  ResponseProductDTO.swift
//  UalaCore
//
//  Created by Uala on 24/08/21.
//

import Foundation

struct ResponseProductDTO: Codable {
    let products: [ProductDTO]
}

public struct ProductDTO: Codable {
    public let productType: ProductType
    public let productStatus: ProductStatus
    public let productNumber: String
    public let baseProduct: Bool
    public let cardNumber: String
    public let cardId: String
    public let pmtRefNo: String
    public let galileoAccountNumber: String
    public let hasPin: Bool
    
    enum CodingKeys: String, CodingKey {
        case productType, productStatus, productNumber, cardNumber,
             cardId, pmtRefNo, galileoAccountNumber, baseProduct, hasPin
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        productType = try container.decode(ProductType.self, forKey: .productType)
        productStatus = try container.decode(ProductStatus.self, forKey: .productStatus)
        productNumber = try container.decode(String.self, forKey: .productNumber)
        baseProduct = try container.decode(Bool.self, forKey: .baseProduct)
        // Conditionally parsing this parameters since not all products have them
        cardNumber = try container.decodeIfPresent(String.self, forKey: .cardNumber) ?? ""
        cardId = try container.decodeIfPresent(String.self, forKey: .cardId) ?? ""
        pmtRefNo = try container.decodeIfPresent(String.self, forKey: .pmtRefNo) ?? ""
        galileoAccountNumber = try container.decodeIfPresent(String.self, forKey: .galileoAccountNumber) ?? ""
        hasPin = try container.decodeIfPresent(Bool.self, forKey: .hasPin) ?? false
    }
}
