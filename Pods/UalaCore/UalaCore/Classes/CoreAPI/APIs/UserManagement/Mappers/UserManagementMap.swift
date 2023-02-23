//
//  UserManagementMap.swift
//  UalaCore
//
//  Created by Ualá on 04/08/21.
//

struct AddBeneficiaryMapper: Mappeable {
    func map<T>(_ data: Data) -> T? {
        return () as? T
    }
}

struct BeneficiaryItemsMapper: MappeableType {
    
    typealias Result = BeneficiaryListResponseDTO
    
    func map<T>(_ data: Data) -> T? {
        return try? BeneficiesBuilder.beneficiary(dto: decode(data)) as? T
    }
}
