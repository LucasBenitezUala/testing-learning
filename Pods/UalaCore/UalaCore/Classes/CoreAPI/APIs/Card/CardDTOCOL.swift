//
//  CardDTOCOL.swift
//  UalaCore
//
//  Created by Flaminia Castaño on 08/08/2022.
//

import Foundation

// MARK: - Card
struct CardDTOCOL: Codable {
    let userId: String
    let cardId: String
    let externalId: String
    let last4Digits: String
    let status: String
    let type: String?
    let isRestricted: Bool
    let createdDate: Double
    let updatedDate: Double
    let hasPin: Bool?
    let hasATMPin: Bool?
    let isReadyToUseVirtualCard: Bool?
    let trackingCode: String?
    let isReplacement: Bool?

    enum CodingKeys: String, CodingKey {
        case userId
        case cardId
        case externalId
        case last4Digits, status, type, isRestricted, createdDate, updatedDate, hasATMPin, hasPin, isReadyToUseVirtualCard, trackingCode, isReplacement
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decode(String.self, forKey: .userId)
        cardId = try values.decode(String.self, forKey: .cardId)
        status = try values.decode(String.self, forKey: .status)
        externalId = try values.decode(String.self, forKey: .externalId)
        last4Digits = try values.decode(String.self, forKey: .last4Digits)
        type = try? values.decodeIfPresent(String.self, forKey: .type)
        isRestricted = try values.decode(Bool.self, forKey: .isRestricted)
        isReadyToUseVirtualCard = try? values.decodeIfPresent(Bool.self, forKey: .isReadyToUseVirtualCard)
        createdDate = try values.decode(Double.self, forKey: .createdDate)
        updatedDate = try values.decode(Double.self, forKey: .updatedDate)
        trackingCode = try? values.decodeIfPresent(String.self, forKey: .trackingCode)
        // Placing both for now so nothing is broken until the full change is done
        hasATMPin = try? values.decodeIfPresent(Bool.self, forKey: .hasATMPin)
        hasPin = try? values.decodeIfPresent(Bool.self, forKey: .hasPin)
        isReplacement = try? values.decodeIfPresent(Bool.self, forKey: .isReplacement)
    }
}
