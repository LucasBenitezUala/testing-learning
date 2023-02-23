//
//  AcquiringAccountDTO.swift
//  UalaCore
//
//  Created by Diego Palomares on 09/11/21.
//

import Foundation

public struct AcquiringAccountDTO: Codable {
    
    public let accountId: String
    public let documentId: String
    public let userType: UserType?
    public var isPPJJ: Bool {
        return userType == .juridical
    }
}

public enum UserType: String, Codable {
    
    case juridical = "JURIDICAL"
    case physical = "PHYSICAL"
    case unknown
    
    public init(from decoder: Decoder) throws {
        guard let rawValue = try? decoder.singleValueContainer().decode(String.self) else {
            self = .unknown
            return
        }
        self = UserType(rawValue: rawValue) ?? .unknown
    }
}
