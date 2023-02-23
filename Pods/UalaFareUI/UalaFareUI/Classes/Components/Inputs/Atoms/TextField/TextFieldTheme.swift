//
//  TextFieldTheme.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 20/07/2022.
//

public protocol TextFieldTheme {
    var typography: TypographyStyle { get }
    var leftIcon: Icon? { get }
    var rightIcon: Icon? { get }
    var placeholder: String? { get }
    var idlePlaceholderColor: UIColor { get }
    var disabledPlaceholderColor: UIColor { get }
    var idleLineColor: UIColor { get }
    var activeLineColor: UIColor { get }
    var errorLineColor: UIColor { get }
    var disabledLineColor: UIColor { get }
}
