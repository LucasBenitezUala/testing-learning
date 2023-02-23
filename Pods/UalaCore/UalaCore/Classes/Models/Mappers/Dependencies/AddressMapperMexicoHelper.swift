//
//  AddressMapperMexicoHelper.swift
//  UalaCore
//
//  Created by uala on 20/04/22.
//

import Foundation

struct AddressMapperMexicoMapper {
    
    static func map(from dict: [String: Any]) -> MexAddress {
        let environment: Environment = CoreEnvironment.shared.environment
        let address: MexAddress = MexAddress()
        
        guard let mapperHelper = environment as? AddressMapperHelperProtocol else { return MexAddress() }
        
        mapperHelper.map(for: address, from: dict)
        
        address.colony = dict.parse("colony")
        address.delegation = dict.parse("delegation")
        address.state = dict.parse("state")
        address.city = address.locality
        address.internalNumber = address.floor
        address.externalNumber = address.department
        
        return address
    }
}
