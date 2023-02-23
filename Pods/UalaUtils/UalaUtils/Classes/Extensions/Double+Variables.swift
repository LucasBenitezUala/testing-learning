//
//  Double+Variables.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 06/10/21.
//

import Foundation

public extension Double {
    
    public var strDecimalWithComma: String {
        return "\(self)".replacingOccurrences(of: ".", with: ",")
    }
}
