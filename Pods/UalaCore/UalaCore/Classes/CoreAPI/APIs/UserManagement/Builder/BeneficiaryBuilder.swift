//
//  BeneficiaryBuilder.swift
//  UalaCore
//
//  Created by Ualá on 04/08/21.
//

import Foundation

struct BeneficiesBuilder {
    static func beneficiary(dto: BeneficiaryListResponseDTO?) throws -> BeneficiariesList {
        guard let dto = dto else { throw UalaError.beneficiariesResponseIsNull}
        do {
            let beneficiariesList = try dto.beneficiaryList.compactMap({ try BeneficiaryBuilder.beneficiary(dto: $0) })
            let percentage = dto.percentage
            return BeneficiariesList(beneficiariesList, percentage)
        } catch {
            throw UalaError.cannotParseBeneficiariesResponse
        }
    }
}

struct BeneficiaryBuilder {
    static func beneficiary(dto: BeneficiaryDTO) throws -> Beneficiary {
        guard let createdDate = Date.fromBancarString(strDate: dto.createdDate),
              let birthDate = Date.fromDatePickerString(strDate: dto.birth) else {
            throw UalaError.beneficiariesDateNull
        }
        
        return Beneficiary(accountId: dto.accountId,
                           beneficiaryEmail: dto.beneficiaryEmail,
                           beneficiaryId: dto.beneficiaryId,
                           birth: birthDate,
                           createdDate: createdDate,
                           lastName: dto.lastName,
                           name: dto.name,
                           percentage: dto.percentage)
    }
}
