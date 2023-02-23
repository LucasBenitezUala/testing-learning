//
//  TextFieldThemeProvider.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 20/07/2022.
//

public protocol TextFieldsThemeProvider {
    func textFieldTheme(theme: Theme, placeholder: String?, rightIcon: Icon?, leftIcon: Icon?) -> TextFieldTheme
    func amountFieldTheme(theme: Theme, fieldType: AmountFieldType, currencySymbol: String, currencyLocaleIdentifier: String) -> AmountFieldTheme
    func codeFieldTheme(theme: Theme, length: Int, keyboardType: UIKeyboardType, isSecureText: Bool) -> CodeFieldTheme
}

public final class DefaultTextFieldsThemeProvider: TextFieldsThemeProvider {
    public init() {}
    
    public func textFieldTheme(theme: Theme, placeholder: String?, rightIcon: Icon?, leftIcon: Icon?) -> TextFieldTheme {
        return DefaultTextFieldTheme(typography: .labelMdRegular,
                                     leftIcon: leftIcon,
                                     rightIcon: rightIcon, 
                                     placeholder: placeholder,
                                     idlePlaceholderColor: theme.color(for: .neutralDark),
                                     disabledPlaceholderColor: theme.color(for: .neutralMiddle),
                                     idleLineColor: theme.color(for: .neutralMiddle),
                                     activeLineColor: theme.color(for: .primaryDefault),
                                     errorLineColor: theme.color(for: .errorMiddle),
                                     disabledLineColor: theme.color(for: .neutralMiddle))
    }
    
    public func amountFieldTheme(theme: Theme, fieldType: AmountFieldType, currencySymbol: String, currencyLocaleIdentifier: String) -> AmountFieldTheme {
        return DefaultAmountFieldTheme(fieldType: fieldType,
                                       typography: .numberLgLight,
                                       idleTextColor: theme.color(for: .neutralDark),
                                       activeTextColor: theme.color(for: .neutralDarker),
                                       idlePlaceholderColor: theme.color(for: .neutralDark),
                                       disabledPlaceholderColor: theme.color(for: .neutralMiddle),
                                       currencySymbol: currencySymbol,
                                       currencyIdleColor: theme.color(for: .neutralDark),
                                       currencyActiveColor: theme.color(for: .primaryDefault),
                                       currencyErrorColor: theme.color(for: .errorMiddle),
                                       currencyDisabledColor: theme.color(for: .neutralMiddle),
                                       currencyLocaleIdentifier: currencyLocaleIdentifier,
                                       idleLineColor: theme.color(for: .neutralMiddle),
                                       activeLineColor: theme.color(for: .primaryDefault),
                                       errorLineColor: theme.color(for: .errorMiddle),
                                       disabledLineColor: theme.color(for: .neutralMiddle))
    }
    
    public func codeFieldTheme(theme: Theme, length: Int, keyboardType: UIKeyboardType, isSecureText: Bool) -> CodeFieldTheme {
        return DefaultCodeFieldTheme(typography: .numberMdRegular,
                                     length: length,
                                     textColor: theme.color(for: .neutralDarker),
                                     idleBorderColor: theme.color(for: .neutralMiddle),
                                     activeBorderColor: theme.color(for: .primaryDefault),
                                     errorBorderColor: theme.color(for: .errorMiddle),
                                     defaultFillColor: .clear,
                                     disabledFillColor: theme.color(for: .neutralLight),
                                     keyboardType: keyboardType,
                                     isSecureText: isSecureText)
    }
}
