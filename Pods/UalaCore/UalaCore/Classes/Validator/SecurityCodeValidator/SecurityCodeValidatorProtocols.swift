//
//  SecurityCodeValidatorProtocols.swift
//  UalaCore
//
//  Created by Rodrigo Torres on 04/05/2022.
//

import Foundation
import Validator

public protocol SecurityCodeValidatorProtocols {
    func validate(securityCode: String) -> ValidationResult
}
