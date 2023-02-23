//
//  MexUser.swift
//  Alamofire
//
//  Created by Enzo Digiano on 27/10/2020.
//

public class MexUser: User, GenericUser {
    public var documentId: String?
    public var documentType: String?
    public var firstLastName: String?
    public var secondLastName: String?
    public var occupation: String?
    public var birthEntity: String?
    public var coordinates: String?
    public var username: String?
    public var createdDate: String?
    public var updatedDate: String?

    public var curp: String? { documentId }
    override public var document: String? {
        get {
            documentType
        }
        set {
            documentType = newValue
        }
    }
}
