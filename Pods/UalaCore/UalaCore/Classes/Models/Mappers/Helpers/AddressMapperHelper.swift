//
//  AddressMapperHelper.swift
//  UalaCore
//
//  Created by uala on 20/04/22.
//

import Foundation

protocol AddressMapperHelperProtocol {
    func mapCommonData(from dict: [String: Any]) -> Address
    func getProvidence(code: String?) -> Province?
    func map(for address: Address, from dict: [String: Any])
}

extension AddressMapperHelperProtocol {
    
    func getProvidence(code: String?) -> Province? {
        let provincies = Province.fromLocalBundle()
        return provincies.first(where: { $0.code == code })
    }
    
    func mapCommonData(from dict: [String: Any]) -> Address {
        let address = Address()
        map(for: address, from: dict)
        return address
    }
    
    func map(for address: Address, from dict: [String: Any]) {
        address.province = getProvidence(code: dict.parse("province") )
        address.locality = dict.parse("city")
        address.street = dict.parse("street")
        address.number = dict.parse("number")
        address.floor = dict.parse("floor")
        address.department = dict.parse("apartment")
        address.observations = dict.parse("observations")
        address.zipCode = dict.parse("zipCode")
    }
}

extension Argentina: AddressMapperHelperProtocol {}
extension ArgentinaBank: AddressMapperHelperProtocol {}
extension Mexico: AddressMapperHelperProtocol {}
extension MexicoABC: AddressMapperHelperProtocol {}

extension Colombia: AddressMapperHelperProtocol {
    func getProvidence(code: String?) -> Province? {
        Province(code: "", name: code ?? "")
    }
}
