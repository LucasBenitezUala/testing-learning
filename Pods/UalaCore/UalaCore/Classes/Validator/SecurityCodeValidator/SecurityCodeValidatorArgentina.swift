//
//  SecurityCodeValidator.swift
//  Alamofire
//
//  Created by Rodrigo Torres on 21/04/2022.
//

import Foundation
import Validator

public final class SecurityCodeValidator: UalaValidator, SecurityCodeValidatorProtocols {
    
    private let securityCodeLengthModel: SecurityLenghtAuthSecurityProtocol
    
    public init(securityCodeLengthModel: SecurityLenghtAuthSecurityProtocol = SecurityCodeLengthModelArgentina()) {
        self.securityCodeLengthModel = securityCodeLengthModel
    }
    
    public override func validate(securityCode: String) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        
        rules.add(rule: ValidationRuleLength(min: securityCodeLengthModel.minLength,
                                             max: securityCodeLengthModel.maxLength,
                                             error: UalaError.pinCodeInvalidFormat))
        
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.numbers,
                                              error: UalaError.pinCodeInvalidFormat))
        
        rules.add(rule: AuthSecurityPattern(pattern: securityCode,
                                            error: UalaError.pinCodeInvalidNumberRepeated,
                                            maxLenght: securityCodeLengthModel.maxNumberRepeated))
        
        rules.add(rule: AuthSecurityPattern(pattern: securityCode,
                                            error: UalaError.pinCodeInvalidNumberSequence,
                                            directionPattern: .ascending,
                                            maxLenght: securityCodeLengthModel.maxNumberConsecutive))
        
        rules.add(rule: AuthSecurityPattern(pattern: securityCode,
                                            error: UalaError.pinCodeInvalidNumberSequence,
                                            directionPattern: .descending,
                                            maxLenght: securityCodeLengthModel.maxNumberConsecutive))
        
        return securityCode.validate(rules: rules)
    }
}
