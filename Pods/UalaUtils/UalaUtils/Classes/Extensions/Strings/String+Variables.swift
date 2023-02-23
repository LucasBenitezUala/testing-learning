//
//  String.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 21/09/21.
//

import Foundation

extension String: LocalizedError {
    
    public var errorDescription: String? {
        return self
    }
    
    public var filterNumbers: String {
        return self.filter("0123456789".contains)
    }
}
