//
//  BeneficiaryDTO.swift
//  UalaCore
//
//  Created by Ualá on 04/08/21.
//

import Foundation

struct BeneficiaryListResponseDTO: Decodable {
    var beneficiaryList: [BeneficiaryDTO]
    var percentage: Int
    
    enum CodingKeys: String, CodingKey {
        case beneficiaryList = "beneficiaries",
             percentage = "availablePercentage"
    }
}

struct BeneficiaryDTO: Decodable {
    
    var accountId,
        beneficiaryEmail,
        beneficiaryId,
        birth,
        createdDate,
        lastName,
        name: String
    
    let percentage: Int
}

extension BeneficiaryDTO {
    enum CodingKeys: String, CodingKey {
        case accountId = "AccountId",
             beneficiaryEmail = "BeneficiaryEmail",
             beneficiaryId = "BeneficiaryId",
             birth = "Birth",
             createdDate = "CreatedDate",
             lastName = "LastName",
             name = "Name",
             percentage = "Percentage"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountId = try values.decode(String.self, forKey: .accountId)
        beneficiaryEmail = try values.decode(String.self, forKey: .beneficiaryEmail)
        beneficiaryId = try values.decode(String.self, forKey: .beneficiaryId)
        birth = try values.decode(String.self, forKey: .birth)
        createdDate = try values.decode(String.self, forKey: .createdDate)
        lastName = try values.decode(String.self, forKey: .lastName)
        name = try values.decode(String.self, forKey: .name)
        percentage = try values.decode(Int.self, forKey: .percentage)
    }
}
