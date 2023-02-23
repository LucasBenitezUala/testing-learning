//
//  SecurityCodeLenghtModelArgentina.swift
//  UalaCore
//
//  Created by Rodrigo Torres on 29/04/2022.
//

import Foundation

public struct SecurityCodeLengthModelArgentina: SecurityLenghtAuthSecurityProtocol {
    
    public init() {
        // Init for avoid internal access error
    }
    
    public var maxLength: Int = 6
    public var minLength: Int = 6
    public var maxNumberRepeated: Int = 4
    public var maxNumberConsecutive: Int = 4
}
