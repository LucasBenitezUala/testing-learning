//
//  PasswordLenghtAuthSecurityProtocol.swift
//  UalaCore
//
//  Created by Rodrigo Torres on 29/04/2022.
//

import Foundation

public protocol PasswordLenghtAuthSecurityProtocol {
    var passwordConsecutive: Int { get }
    var passwordRepeated: Int { get }
}
