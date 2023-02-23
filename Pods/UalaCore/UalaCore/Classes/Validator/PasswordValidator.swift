//
//  PasswordValidator.swift
//  UalaCore
//
//  Created by Aldo Martinez on 15/02/22.
//

import Foundation
import Validator

public protocol PasswordValidator {
    func validate(password: String) -> ValidationResult
}

public final class MexicoABCPasswordValidator: PasswordValidator {
    
    private let passwordCodeLengthModel: PasswordLenghtAuthSecurityProtocol
    
    public init(passwordCodeLengthModel: PasswordLenghtAuthSecurityProtocol = PasswordLenghtModelMexico()) {
        self.passwordCodeLengthModel = passwordCodeLengthModel
    }
    
    public func validate(password: String) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        
        rules.add(rule: ValidationRuleLength(min: 6, max: 16, error: UalaError.passwordInvalidLength))
        rules.add(rule: AuthSecurityPattern(pattern: password, error: UalaError.passwordInvalidCharacterSequence, directionPattern: .ascending, maxLenght: passwordCodeLengthModel.passwordConsecutive))
        rules.add(rule: AuthSecurityPattern(pattern: password, error: UalaError.passwordInvalidCharacterSequence, directionPattern: .descending, maxLenght: passwordCodeLengthModel.passwordConsecutive))
        rules.add(rule: UalaPasswordPattern(pattern: password, error: UalaError.passwordInvalidContainsUala))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.password, error: UalaError.passwordInvalidFormat))

        return password.validate(rules: rules)
    }
}
