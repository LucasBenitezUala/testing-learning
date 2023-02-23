//
//  UserCatalog.swift
//  UalaCore
//
//  Created by Matías Schwalb on 07/06/2022.
//

public struct UserCatalog: Codable {
    public let id: String
    public let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
    }
}
