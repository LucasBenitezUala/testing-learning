//
//  UserMapperHelper.swift
//  UalaCore
//
//  Created by uala on 20/04/22.
//

struct UserMapperHelper {
    static func mapInfo(_ user: CommonUser, from dto: RemoteUser.User) {
        let environment: Environment = CoreEnvironment.shared.environment
        guard let helper: UserMapperHelperProtocol = environment as? UserMapperHelperProtocol else { return }
        helper.mapGender(for: user, from: dto)
        helper.mapAddress(for: user, from: dto)
        helper.mapPicture(for: user, from: dto)
        helper.mapDeliveryAddress(for: user, from: dto)
    }
}

protocol UserMapperHelperProtocol {
    func mapGender(for user: CommonUser, from dto: RemoteUser.User)
    func mapPicture(for user: CommonUser, from dto: RemoteUser.User)
    func mapAddress(for user: CommonUser, from dto: RemoteUser.User)
    func mapDeliveryAddress(for user: CommonUser, from dto: RemoteUser.User)
}

extension UserMapperHelperProtocol {
    func mapGender(for user: CommonUser, from dto: RemoteUser.User) {
        if let gender = dto.gender, !gender.isEmpty {
            user.gender = Gender(rawValue: gender)
        } else {
            user.gender = nil
        }
    }
    
    func mapPicture(for user: CommonUser, from dto: RemoteUser.User) {
        user.picture = dto.selfiePicture?.notNullString()
    }
    
    func mapAddress(for user: CommonUser, from dto: RemoteUser.User) {
        let addressDic = BancarMetadata.dictFromBancarMetadata(metadata: dto.address ?? "")
        user.address = AddressMapper.map(from: addressDic)
    }
    
    func mapDeliveryAddress(for user: CommonUser, from dto: RemoteUser.User) {
        let deliveryAddressDic = BancarMetadata.dictFromBancarMetadata(metadata: dto.deliveryAddress ?? "")
        user.deliveryAddress = AddressMapper.map(from: deliveryAddressDic)
    }
}

extension Colombia: UserMapperHelperProtocol {}
extension ArgentinaBank: UserMapperHelperProtocol {}

extension Argentina: UserMapperHelperProtocol {
    func mapPicture(for user: CommonUser, from dto: RemoteUser.User) {
        user.picture = dto.picture?.notNullString()
    }
}

extension Mexico: UserMapperHelperProtocol {
    func mapGender(for user: CommonUser, from dto: RemoteUser.User) {
        MexUserMapperHelper.mapGender(for: user, from: dto)
    }
    
    func mapAddress(for user: CommonUser, from dto: RemoteUser.User) {
        MexUserMapperHelper.mapAddress(for: user, from: dto)
    }
    
    func mapDeliveryAddress(for user: CommonUser, from dto: RemoteUser.User) {
        MexUserMapperHelper.mapDeliveryAddress(for: user, from: dto)
    }
}

extension MexicoABC: UserMapperHelperProtocol {
    func mapGender(for user: CommonUser, from dto: RemoteUser.User) {
        MexUserMapperHelper.mapGender(for: user, from: dto)
    }
    
    func mapAddress(for user: CommonUser, from dto: RemoteUser.User) {
        MexUserMapperHelper.mapAddress(for: user, from: dto)
    }
    
    func mapDeliveryAddress(for user: CommonUser, from dto: RemoteUser.User) {
        MexUserMapperHelper.mapDeliveryAddress(for: user, from: dto)
    }
}
