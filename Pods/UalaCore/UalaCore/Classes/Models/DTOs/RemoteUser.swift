//
//  RemoteUser.swift
//  UalaCore
//
//  Created by Ualá on 11/04/2022.
//

public struct RemoteUser: Decodable {
    let user: User
    
    public struct User {
        let email: String
        let userId: String
        let phoneNumber: String?
        let phoneNumberCountryCode: String?
        let documentId: String?
        let CURP: String?
        let givenName: String?
        let familyName: String?
        let birthPlace: String?
        let nationality: String?
        let gender: String?
        let birthDate: String?
        let cuil: String?
        let picture: String?
        let selfiePicture: String?
        let idFrontPicture: String?
        let idBackPicture: String?
        let pep: String?
        let parentGivenName: String?
        let parentId: String?
        let parentFamilyName: String?
        let parentRelationShip: String?
        let parentEmail: String?
        let parentPhoneNumber: String?
        let isPhoneVerified: String?
        let obligatedEntity: String?
        let firstLastName: String?
        let secondLastName: String?
        let occupation: String?
        let birthEntity: String?
        let coordinates: String?
        let username: String?
        let documentType: String?
        let address: String?
        let deliveryAddress: String?
        var createdDate: String?
        var updatedDate: String?
    }
}

extension RemoteUser.User: Decodable {
    
    enum RootContainerCodingKey: String, CodingKey {
        case user
    }
    
    enum CodingKeys: String, CodingKey {
        case email, userId, phoneNumber, phoneNumberCountryCode, documentId, CURP,
             givenName, familyName, birthPlace, nationality, gender, birthDate, cuil,
             picture, selfiePicture, idFrontPicture, idBackPicture, pep, parentGivenName,
             parentId, parentFamilyName, parentRelationShip, parentEmail, parentPhoneNumber,
             isPhoneVerified, obligatedEntity, firstLastName, secondLastName, occupation,
             birthEntity, coordinates, username, documentType, address, deliveryAddress,
             createdDate, updatedDate
    }
    
    // swiftlint:disable function_body_length
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootContainerCodingKey.self)
        let values = try rootContainer.nestedContainer(keyedBy: CodingKeys.self,
                                                       forKey: .user)
        email = try values.decode(String.self, forKey: .email)
        userId = try values.decode(String.self, forKey: .userId)
        phoneNumber = try? values.decode(String.self, forKey: .phoneNumber)
        phoneNumberCountryCode = try? values.decode(String.self, forKey: .phoneNumberCountryCode)
        documentId = try? values.decode(String.self, forKey: .documentId)
        CURP = try? values.decode(String.self, forKey: .CURP)
        givenName = try? values.decode(String.self, forKey: .givenName)
        familyName = try? values.decode(String.self, forKey: .familyName)
        birthPlace = try? values.decode(String.self, forKey: .birthPlace)
        nationality = try? values.decode(String.self, forKey: .nationality)
        gender = try? values.decode(String.self, forKey: .gender)
        birthDate = try? values.decode(String.self, forKey: .birthDate)
        cuil = try? values.decode(String.self, forKey: .cuil)
        picture = try? values.decode(String.self, forKey: .picture)
        selfiePicture = try? values.decode(String.self, forKey: .selfiePicture)
        idFrontPicture = try? values.decode(String.self, forKey: .idFrontPicture)
        idBackPicture = try? values.decode(String.self, forKey: .idBackPicture)
        pep = try? values.decode(String.self, forKey: .pep)
        parentGivenName = try? values.decode(String.self, forKey: .parentGivenName)
        parentId = try? values.decode(String.self, forKey: .parentId)
        parentFamilyName = try? values.decode(String.self, forKey: .parentFamilyName)
        parentRelationShip = try? values.decode(String.self, forKey: .parentRelationShip)
        parentEmail = try? values.decode(String.self, forKey: .parentEmail)
        parentPhoneNumber = try? values.decode(String.self, forKey: .parentPhoneNumber)
        isPhoneVerified = try? values.decode(String.self, forKey: .isPhoneVerified)
        obligatedEntity = try? values.decode(String.self, forKey: .obligatedEntity)
        firstLastName = try? values.decode(String.self, forKey: .firstLastName)
        secondLastName = try? values.decode(String.self, forKey: .secondLastName)
        occupation = try? values.decode(String.self, forKey: .occupation)
        birthEntity = try? values.decode(String.self, forKey: .birthEntity)
        coordinates = try? values.decode(String.self, forKey: .coordinates)
        username = try? values.decode(String.self, forKey: .username)
        documentType = try? values.decode(String.self, forKey: .documentType)
        address = try? values.decode(String.self, forKey: .address)
        deliveryAddress = try? values.decode(String.self, forKey: .deliveryAddress)

        if let createdDate = try? values.decode(Int.self, forKey: .createdDate) {
            self.createdDate = String(createdDate)
        }

        if let updatedDate = try? values.decode(Int.self, forKey: .updatedDate) {
            self.updatedDate = String(updatedDate)
        }
    }
}
