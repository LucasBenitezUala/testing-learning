//
//  MexUserMapperHelper.swift
//  UalaCore
//
//  Created by uala on 21/04/22.
//

struct MexUserMapperHelper {
    static func mapGender(for user: CommonUser, from dto: RemoteUser.User) {
        if let gender = dto.gender?.notNullString() {
            user.gender = gender == "Male" ? .male : .female
        }
    }
    
    static func mapAddress(for user: CommonUser, from dto: RemoteUser.User) {
        if let address = dto.address, !address.isEmpty {
            let data = address.data(using: .utf8)
            do {
                let dictionary = address.convertToDictinary()
                user.address = AddressMapper.map(from: dictionary ?? [:])
            }
        }
    }
    
    static func mapDeliveryAddress(for user: CommonUser, from dto: RemoteUser.User) {
        if let deliveryAddress = dto.deliveryAddress, !deliveryAddress.isEmpty {
            let data = deliveryAddress.data(using: .utf8)
            do {
                let dictionary = deliveryAddress.convertToDictinary()
                user.deliveryAddress = AddressMapper.map(from: dictionary ?? [:])
            }
        }
    }
}
