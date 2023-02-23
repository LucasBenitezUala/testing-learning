//
//  PasswordLengthModelMexico.swift
//  Alamofire
//
//  Created by Rodrigo Torres on 29/04/2022.
//

import Foundation

public struct PasswordLenghtModelMexico: PasswordLenghtAuthSecurityProtocol {
    
    public init() {
        // Init for avoid internal access error
    }
    
    public var passwordConsecutive: Int = 4
    public var passwordRepeated: Int = 4
}
