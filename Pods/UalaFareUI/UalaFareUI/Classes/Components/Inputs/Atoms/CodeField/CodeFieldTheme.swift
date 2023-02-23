//
//  CodeFieldTheme.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 16/08/2022.
//

public protocol CodeFieldTheme {
    var typography: TypographyStyle { get }
    var length: Int { get }
    var textColor: UIColor { get }
    var idleBorderColor: UIColor { get }
    var activeBorderColor: UIColor { get }
    var errorBorderColor: UIColor { get }
    var defaultFillColor: UIColor { get }
    var disabledFillColor: UIColor { get }
    var keyboardType: UIKeyboardType { get }
    var isSecureText: Bool { get }
}

public struct DefaultCodeFieldTheme: CodeFieldTheme {
    public var typography: TypographyStyle
    public var length: Int
    public var textColor: UIColor
    public var idleBorderColor: UIColor
    public var activeBorderColor: UIColor
    public var errorBorderColor: UIColor
    public var defaultFillColor: UIColor
    public var disabledFillColor: UIColor
    public var keyboardType: UIKeyboardType
    public var isSecureText: Bool
}
