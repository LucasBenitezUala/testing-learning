//
//  UserMulticountry.swift
//  UalaCore
//
//  Created by Matías Schwalb on 01/06/2022.
//

// MARK: - UserMulticountry
public struct UserMulticountry: Codable {
    let accountDocumentID, accountID: String?
    let address: AddressMulticountry?
    let avatarPicture: String?
    let bankData: BankDataClass?
    let birthDate, birthEntity, birthPlace, clabe: String?
    let contractSign, coordinates, createdDate: String?
    let crs: Bool?
    let deliveryAddress: AddressMulticountry?
    let documentID, documentType, email, expeditionDate: String?
    let expirationDate, externalAccountID, externalID: String?
    let fatca: Bool?
    let gender, givenName: String?
    let hasPin: Bool?
    let idBackPicture, idFrontPicture: String?
    let identity: Identity?
    let income: String?
    let isPhoneVerified: Bool?
    let lastName, maritalStatus: String?
    let metadata: BankDataClass?
    let nationality, numberID, occupation, parentEmail: String?
    let pep: Bool?
    let personalDataTreatmentAcceptanceDate, phoneNumber, phoneNumberCountryCode, privacySign: String?
    let secondLastName, secondName, selfiePicture, sensitiveDataTreatmentAcceptanceDate: String?
    let soDocs: Bool?
    let status, taxDocument, updatedDate, userID: String?
    let userName, userType: String?
    let specialCondition, belongsToCollective: String?

    enum CodingKeys: String, CodingKey {
        case accountDocumentID = "AccountDocumentId"
        case accountID = "AccountId"
        case address = "Address"
        case avatarPicture = "AvatarPicture"
        case bankData = "BankData"
        case birthDate = "BirthDate"
        case birthEntity = "BirthEntity"
        case birthPlace = "BirthPlace"
        case clabe = "Clabe"
        case contractSign = "ContractSign"
        case coordinates = "Coordinates"
        case createdDate = "CreatedDate"
        case crs = "Crs"
        case deliveryAddress = "DeliveryAddress"
        case documentID = "DocumentId"
        case documentType = "DocumentType"
        case email = "Email"
        case expeditionDate = "ExpeditionDate"
        case expirationDate = "ExpirationDate"
        case externalAccountID = "ExternalAccountId"
        case externalID = "ExternalId"
        case fatca = "Fatca"
        case gender = "Gender"
        case givenName = "GivenName"
        case hasPin = "HasPin"
        case idBackPicture = "IdBackPicture"
        case idFrontPicture = "IdFrontPicture"
        case identity = "Identity"
        case income = "Income"
        case isPhoneVerified = "IsPhoneVerified"
        case lastName = "LastName"
        case maritalStatus = "MaritalStatus"
        case metadata = "Metadata"
        case nationality = "Nationality"
        case numberID = "NumberId"
        case occupation = "Occupation"
        case parentEmail = "ParentEmail"
        case pep = "Pep"
        case personalDataTreatmentAcceptanceDate = "PersonalDataTreatmentAcceptanceDate"
        case phoneNumber = "PhoneNumber"
        case phoneNumberCountryCode = "PhoneNumberCountryCode"
        case privacySign = "PrivacySign"
        case secondLastName = "SecondLastName"
        case secondName = "SecondName"
        case selfiePicture = "SelfiePicture"
        case sensitiveDataTreatmentAcceptanceDate = "SensitiveDataTreatmentAcceptanceDate"
        case soDocs = "SoDocs"
        case status = "Status"
        case taxDocument = "TaxDocument"
        case updatedDate = "UpdatedDate"
        case userID = "UserId"
        case userName = "UserName"
        case userType = "UserType"
        case specialCondition = "SpecialCondition"
        case belongsToCollective = "BelongsToCollective"
    }
}

// MARK: - Address
struct AddressMulticountry: Codable {
    let addressNumber, addressReference, apartment, city: String?
    let floor, observations, province, state: String?
    let street, streetNumber, zipCode, colony: String?
    let delegation, externalNumber: String?

    enum CodingKeys: String, CodingKey {
        case addressNumber = "AddressNumber"
        case addressReference = "AddressReference"
        case apartment = "Apartment"
        case city = "City"
        case floor = "Floor"
        case observations = "Observations"
        case province = "Province"
        case state = "State"
        case street = "Street"
        case streetNumber = "StreetNumber"
        case zipCode = "ZipCode"
        case colony, delegation, externalNumber
    }
}

// MARK: - BankDataClass
struct BankDataClass: Codable {
    let additionalProp1: AdditionalProp1?
}

// MARK: - AdditionalProp1
struct AdditionalProp1: Codable {
}

// MARK: - Identity
struct Identity: Codable {
    let deviceID, userID: String?

    enum CodingKeys: String, CodingKey {
        case deviceID = "DeviceID"
        case userID = "UserID"
    }
}
