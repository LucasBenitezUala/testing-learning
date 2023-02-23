//
//  PasswordCollectorViewDependenciesType.swift
//  UalaUI
//
//  Created by Agustina Ardisana on 31/10/2022.
//

import Foundation

public protocol PasswordCollectorViewDependenciesType {
    var parameters: PasswordCollectorParametersType { get }
    var uiConstants: PasswordCollectorUiConstantsType { get }
}

public protocol PasswordCollectorParametersType {
    var title: String? { get }
    var description: String? { get }
    var placeholder: String { get }
    var underlineErrorDescription: String { get }
    var primaryActionTitle: String? { get }
    var keyboardType: UIKeyboardType { get }
}

public protocol PasswordCollectorUiConstantsType {
    var horizontalInsets: CGFloat { get }
}
