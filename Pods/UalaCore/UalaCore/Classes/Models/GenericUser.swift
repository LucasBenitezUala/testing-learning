//
//  GenericUser.swift
//  UalaCore
//
//  Created by Ualá on 07/04/22.
//

public protocol GenericUser: AnyObject {
    var documentId: String? { get set }
    var documentType: String? { get set }
    var firstLastName: String? { get set }
    var secondLastName: String? { get set }
    var occupation: String? { get set }
    var birthEntity: String? { get set }
    var coordinates: String? { get set }
    var username: String? { get set }
    var createdDate: String? { get set }
    var updatedDate: String? { get set }
}

public protocol CommonUser: AnyObject {
    var userId: String? { get set }
    var email: String { get set }
    var phoneNumber: String? { get set }
    var document: String? { get set }
    var givenName: String? { get set }
    var familyName: String? { get set }
    var country: String? { get set }
    var nationality: String? { get set }
    var gender: Gender? { get set }
    var birthdate: String? { get set }
    var cuil: String? { get set }
    var address: Address? { get set }
    var deliveryAddress: Address? { get set }
    var picture: String? { get set }
    var dniPictureFront: String? { get set }
    var dniPictureBack: String? { get set }
    var isPep: Bool? { get set }
    var parentName: String? { get set }
    var parentEmail: String? { get set }
    var parentPhoneNumber: String? { get set }
    var parentRelationship: String? { get set }
    var parentFamilyName: String? { get set }
    var parentDNI: String? { get set }
    var isPhoneVerified: Bool { get set }
    var obligatedEntity: String? { get set }
}
