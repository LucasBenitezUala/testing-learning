//
//  PhoneCollectorViewDependenciesType.swift
//  UalaUI
//
//  Created by Andrés Abraham Bonilla Gómex on 17/05/22.
//

import Foundation

public protocol PhoneCollectorViewDependenciesType {
    var parameters: PhoneCollectorParametersType { get }
    var uiConstants: PhoneCollectorConstantsType { get }
}

public protocol PhoneCollectorParametersType {
    var title: String { get }
    var description: String { get }
    var prefixTitle: String { get }
    var prefixPlaceholder: String { get }
    var phonePlaceholder: String { get }
    var underlinePlaceholder: String { get }
    var underlineErrorDescription: String { get }
    var primaryActionTitle: String { get }
}

public protocol PhoneCollectorConstantsType {
    var sublabelSize: CGFloat { get }
    var textFieldLeftInset: CGFloat { get }
}
