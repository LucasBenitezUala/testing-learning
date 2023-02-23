//
//  AddressMapperDependencies.swift
//  Alamofire
//
//  Created by Enzo Digiano on 27/10/2020.
//

import Foundation

protocol AddressMapperDependenciesProtocol {
    func map(from dict: [String: Any]) -> Address
}

extension AddressMapperDependenciesProtocol {
    func map(from dict: [String: Any]) -> Address {
        let environment: Environment = CoreEnvironment.shared.environment
        guard let mapperHelper = environment as? AddressMapperHelperProtocol,
              let address = mapperHelper.mapCommonData(from: dict) as? Address
        else { return Address() }
        return address
    }
}

extension Argentina: AddressMapperDependenciesProtocol {}
extension ArgentinaBank: AddressMapperDependenciesProtocol {}
extension Colombia: AddressMapperDependenciesProtocol {}

extension Mexico: AddressMapperDependenciesProtocol {
    func map(from dict: [String: Any]) -> Address {
        return AddressMapperMexicoMapper.map(from: dict)
    }
}

extension MexicoABC: AddressMapperDependenciesProtocol {
    func map(from dict: [String: Any]) -> Address {
        return AddressMapperMexicoMapper.map(from: dict)
    }
}
