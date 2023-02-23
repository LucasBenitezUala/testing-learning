//
//  InputTextThemeProvider.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 22/07/2022.
//

public protocol InputsThemeProvider {
    func inputTextTheme(_ parameters: InputTextThemeParameters) -> InputTextTheme
    func inputAmountTheme(_ parameters: InputAmountThemeParameters) -> InputAmountTheme
    func inputCodeField(codeFieldTheme: CodeFieldTheme, helperTheme: InputHelperTheme, helperText: String?, helperType: InputHelperType?) -> InputCodeTheme
}

public final class DefaultInputsThemeProvider: InputsThemeProvider {
    
    public init() {}
    
    public func inputTextTheme(_ parameters: InputTextThemeParameters) -> InputTextTheme {
        return DefaultInputTextTheme(helperTheme: parameters.helperTheme,
                                     title: parameters.title,
                                     textFieldTheme: parameters.textFieldTheme,
                                     helperText: parameters.helperText,
                                     helperType: parameters.helperType)
    }
    
    public func inputAmountTheme(_ parameters: InputAmountThemeParameters) -> InputAmountTheme {
        return DefaultInputAmountTheme(title: parameters.title,
                                       helperTheme: parameters.helperTheme,
                                       amountFieldTheme: parameters.amountFieldTheme,
                                       helperText: parameters.helperText,
                                       helperType: parameters.helperType)
    }
    
    public func inputCodeField(codeFieldTheme: CodeFieldTheme, helperTheme: InputHelperTheme, helperText: String?, helperType: InputHelperType?) -> InputCodeTheme {
        return DefaultInputCodeTheme(codeFieldTheme: codeFieldTheme,
                                     helperTheme: helperTheme,
                                     helperText: helperText,
                                     helperType: helperType)
    }
}

public struct InputTextThemeParameters {
    let helperTheme: InputHelperTheme
    let textFieldTheme: TextFieldTheme
    let title: InputTitle?
    let helperText: String?
    let helperType: InputHelperType?
}

public struct InputAmountThemeParameters {
    let helperTheme: InputHelperTheme
    let amountFieldTheme: AmountFieldTheme
    let title: InputTitle?
    let helperText: String?
    let helperType: InputHelperType?
}
