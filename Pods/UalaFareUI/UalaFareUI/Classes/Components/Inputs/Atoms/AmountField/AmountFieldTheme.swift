//
//  AmountFieldTheme.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 03/08/2022.
//

import UIKit.NSText

public enum AmountFieldType {
    case currencyDefault
    case currencyNumber
    
    var typography: TypographyStyle {
        switch self {
        case .currencyDefault:
            return .numberLgLight
        case .currencyNumber:
            return .numberMdLight
        }
    }
    
    var size: CGFloat {
        switch self {
        case .currencyDefault:
            return 40
        case .currencyNumber:
            return 32
        }
    }
    
    var alignment: NSTextAlignment {
        switch self {
        case .currencyDefault:
            return .left
        case .currencyNumber:
            return .right
        }
    }
}

public protocol AmountFieldTheme {
    var fieldType: AmountFieldType { get }
    var typography: TypographyStyle { get }
    var idleTextColor: UIColor { get }
    var activeTextColor: UIColor { get }
    var idlePlaceholderColor: UIColor { get }
    var disabledPlaceholderColor: UIColor { get }
    var currencySymbol: String { get }
    var currencyIdleColor: UIColor { get }
    var currencyActiveColor: UIColor { get }
    var currencyErrorColor: UIColor { get }
    var currencyDisabledColor: UIColor { get }
    var currencyLocaleIdentifier: String { get } // es_AR, es_CO, es_MX
    var idleLineColor: UIColor { get }
    var activeLineColor: UIColor { get }
    var errorLineColor: UIColor { get }
    var disabledLineColor: UIColor { get }
}

struct DefaultAmountFieldTheme: AmountFieldTheme {
    var fieldType: AmountFieldType
    var typography: TypographyStyle
    var idleTextColor: UIColor
    var activeTextColor: UIColor
    var idlePlaceholderColor: UIColor
    var disabledPlaceholderColor: UIColor
    var currencySymbol: String
    var currencyIdleColor: UIColor
    var currencyActiveColor: UIColor
    var currencyErrorColor: UIColor
    var currencyDisabledColor: UIColor
    var currencyLocaleIdentifier: String
    var idleLineColor: UIColor
    var activeLineColor: UIColor
    var errorLineColor: UIColor
    var disabledLineColor: UIColor
}
