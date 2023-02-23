//
//  UserMulticountrySpecialFields.swift
//  UalaCore
//
//  Created by Matías Schwalb on 06/06/2022.
//

public struct UserMulticountrySpecialFields {
    public init(specialCondition: String, belongsToCollective: String) {
        self.specialCondition = specialCondition
        self.belongsToCollective = belongsToCollective
    }

    public let specialCondition: String
    public let belongsToCollective: String

    public static func createEntity(from userMulticountry: UserMulticountry) -> UserMulticountrySpecialFields? {
        guard let specialCondition = userMulticountry.specialCondition, let belongsToCollective = userMulticountry.belongsToCollective else {
            return nil
        }
        return UserMulticountrySpecialFields(specialCondition: specialCondition, belongsToCollective: belongsToCollective)
    }
}
