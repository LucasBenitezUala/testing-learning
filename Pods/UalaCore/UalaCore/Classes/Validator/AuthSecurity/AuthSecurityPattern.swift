//
//  AuthSecurityPattern.swift
//  Alamofire
//
//  Created by Rodrigo Torres on 21/04/2022.
//

import Foundation
import Validator

public struct AuthSecurityPattern: ValidationRule {
    public let pattern: String
    public let error: ValidationError
    internal let directionPattern: DirectionConsecutivePattern?
    internal let maxLenght: Int
    internal let typeValidation: TypeValidation
    
    /// Init for Consecutive Number and char
    internal init(pattern: String, error: ValidationError, directionPattern: DirectionConsecutivePattern, maxLenght: Int) {
        self.pattern = pattern
        self.typeValidation = TypeValidation.consecutive
        self.error = error
        self.directionPattern = directionPattern
        self.maxLenght = maxLenght
    }
    
    /// Init for Repeated Number and char
    internal init(pattern: String, error: ValidationError, maxLenght: Int) {
        self.pattern = pattern
        self.typeValidation = TypeValidation.repeated
        self.error = error
        self.maxLenght = maxLenght
        self.directionPattern = nil
    }
    
    public func validate(input: String?) -> Bool {
        guard let input = input?.lowercased(), !input.isEmpty else { return false }
        
        let threshold: Int = maxLenght
        var consecutiveScalars: Int = 1
        let increment: Int = directionPattern == .ascending ? 1 : -1
        
        for (index, character) in input.enumerated() {
            if index == 0 {
                continue
            }
            
            let scalar = UnicodeScalar(String(character))?.value ?? 0
            let previousScalar = getPreviousScalar(index: index - 1, input: input)?.value ?? 0
            
            switch typeValidation {
            case .consecutive:
                guard (Int(scalar) - Int(previousScalar) - increment) == 0 else {
                    consecutiveScalars = 1
                    continue
                }
            case .repeated:
                if Int(scalar) != Int(previousScalar) {
                    consecutiveScalars = 1
                    continue
                }
            }
            
            consecutiveScalars += 1
            if consecutiveScalars >= threshold {
                return false
            }
        }
        return consecutiveScalars <= threshold
    }
    
    private func getPreviousScalar(index: Int, input: String) -> UnicodeScalar? {
        let character = input[input.index(input.startIndex, offsetBy: index)]
        return UnicodeScalar(String(character))
    }
}

public struct UalaPasswordPattern: ValidationRule {
    
    public let pattern: String
    public let error: ValidationError
    
    internal init(pattern: String, error: ValidationError) {
        self.pattern = pattern
        self.error = error
    }
    
    internal init(pattern: ValidationPattern, error: ValidationError) {
        self.init(pattern: pattern.pattern, error: error)
    }
    
    public func validate(input: String?) -> Bool {
        guard let input = input, !input.isEmpty else { return false }
        return !input.lowercased().contains("uala")
    }
}
