//
//  SecurityLenghtAuthSecurityProtocol.swift
//  UalaCore
//
//  Created by Rodrigo Torres on 29/04/2022.
//

import Foundation

public protocol SecurityLenghtAuthSecurityProtocol {
    var maxLength: Int { get }
    var minLength: Int { get }
    var maxNumberRepeated: Int { get }
    var maxNumberConsecutive: Int { get }
}
