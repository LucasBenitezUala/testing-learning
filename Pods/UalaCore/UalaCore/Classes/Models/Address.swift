//
//  Address.swift
//  Uala
//
//  Created by Nelson Domínguez on 28/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public class Address {
    
   public var province: Province?
   public var locality: String?
   public var street: String?
   public var number: String?
   public var floor: String?
   public var department: String?
   public var observations: String?
   public var zipCode: String?
   public var hasStreetNumber: Bool?
    
    public init() { }
}

public extension Address {
    
    static func ==(lhs: Address, rhs: Address) -> Bool {
        
        guard lhs.province == rhs.province,
              lhs.locality == rhs.locality,
              lhs.street == rhs.street,
              lhs.number == rhs.number,
              lhs.floor == rhs.floor,
              lhs.department == rhs.department,
              lhs.observations == rhs.observations,
              lhs.zipCode == rhs.zipCode,
              lhs.hasStreetNumber == rhs.hasStreetNumber
        else { return false }
        
        return true
    }
    
    func jsonString() -> String? {
        
        let province = self.province?.code
        
        let dictionaryAddress = [
            "P": province ?? "",
            "L": locality ?? "",
            "S": street ?? "",
            "N": number ?? "",
            "F": floor ?? "",
            "A": department ?? "",
            "O": observations ?? "",
            "Z": zipCode ?? ""
        ]
        
        guard let jsonData = try? JSONSerialization
                .data(withJSONObject: dictionaryAddress,
                      options: JSONSerialization.WritingOptions(rawValue: 0)) else {
                    return nil
                }

        return String(data: jsonData, encoding: .utf8)
    }
}
