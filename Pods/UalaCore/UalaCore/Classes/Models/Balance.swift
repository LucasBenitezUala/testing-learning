//
//  Balance.swift
//  Uala
//
//  Created by Hasael Oliveros on 7/25/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public class Balance: Decodable {
    public let accountId: String?
    public let availableBalance: Double
    
    public var balanceData: String {
        return availableBalance == 0
        ? "0"
        : availableBalance > 0 ? ">0" : "<0"
    }
    
    private enum CodingKeys: String, CodingKey {
        case accountId, availableBalance
    }
    
    public init(accountId: String,
         availableBalance: Double) {
            self.accountId = accountId
            self.availableBalance = availableBalance
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accountId = try container.decodeIfPresent(String.self, forKey: .accountId)
        let stringBalance = try container.decode(String.self, forKey: .availableBalance)
        availableBalance = Double(stringBalance) ?? 0.0
    }
}
