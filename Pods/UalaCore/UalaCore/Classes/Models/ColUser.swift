//
//  ColUser.swift
//  UalaCore
//
//  Created by Monserrath Castro on 07/04/22.
//

import Foundation

/**
 🇨🇴 User
 */
public class ColUser: User, GenericUser {
    public var documentType: String?
    public var firstLastName: String?
    public var secondLastName: String?
    public var occupation: String?
    public var birthEntity: String?
    public var coordinates: String?
    public var username: String?
    public var documentId: String?
    public var createdDate: String?
    public var updatedDate: String?

    override public var document: String? {
        get {
            documentType
        }
        set {
            documentType = newValue
        }
    }
}
