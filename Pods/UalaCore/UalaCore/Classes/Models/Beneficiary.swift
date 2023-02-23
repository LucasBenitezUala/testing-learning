//
//  Beneficiary.swift
//  UalaCore
//
//  Created by Ualá on 04/08/21.
//

import Foundation

public struct BeneficiariesList {
    public let list: [Beneficiary]
    public let percentage: Int
    
    public init(_ list: [Beneficiary], _ percentage: Int) {
        self.list = list
        self.percentage = percentage
    }
}

public struct Beneficiary {
    public let accountId: String
    public let beneficiaryEmail: String
    public let beneficiaryId: String
    public var birth: Date
    public let createdDate: Date
    public let lastName: String
    public let name: String
    public let percentage: Int
}
