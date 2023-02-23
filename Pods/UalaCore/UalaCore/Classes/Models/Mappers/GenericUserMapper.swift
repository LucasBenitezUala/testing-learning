//
//  GenericUserMapper.swift
//  UalaCore
//
//  Created by Ualá on 07/04/22.
//

typealias FullUser = GenericUser & CommonUser

final class GenericUserMapper {
    static func mapFor(user: GenericUser, dto: RemoteUser.User) {
        user.documentType = dto.documentType?.notNullString()
        user.firstLastName = dto.firstLastName?.notNullString()
        user.secondLastName = dto.secondLastName?.notNullString()
        user.occupation = dto.occupation?.notNullString()
        user.birthEntity = dto.birthEntity?.notNullString()
        user.coordinates = dto.coordinates?.notNullString()
        user.username = dto.username?.notNullString()
        user.createdDate = dto.createdDate
        user.updatedDate = dto.updatedDate
    }
    
    static func mapCommonUser(_ user: CommonUser, from dto: RemoteUser.User) {
        user.userId = dto.userId
        user.phoneNumber = dto.phoneNumber?.notNullString()
        user.givenName = dto.givenName?.notNullString()
        user.familyName = dto.familyName?.notNullString()
        user.country = dto.birthPlace?.notNullString()
        user.nationality = dto.nationality?.notNullString()
        user.birthdate = dto.birthDate?.notNullString()
        user.cuil = dto.cuil?.notNullString()
        user.dniPictureFront = dto.idFrontPicture?.notNullString()
        user.dniPictureBack = dto.idBackPicture?.notNullString()
        
        if let pep = dto.pep, !pep.isEmpty {
            user.isPep = Bool(pep)
        }
        
        user.parentName = dto.parentGivenName?.notNullString()
        user.parentDNI = dto.parentId?.notNullString()
        user.parentFamilyName = dto.parentFamilyName?.notNullString()
        user.parentRelationship = dto.parentRelationShip?.notNullString()
        user.parentEmail = dto.parentEmail?.notNullString()
        user.parentPhoneNumber = dto.parentPhoneNumber?.notNullString()
        
        if let isPhoneVerified = dto.isPhoneVerified?.notNullString() {
            user.isPhoneVerified = Bool(isPhoneVerified) ?? false
        } else {
            user.isPhoneVerified = false
        }
        
        user.obligatedEntity = dto.obligatedEntity
        
        UserMapperHelper.mapInfo(user, from: dto)
    }
    
    static func mapUser(_ user: FullUser, from dto: RemoteUser.User) {
        mapFor(user: user, dto: dto)
        mapCommonUser(user, from: dto)
    }
}
