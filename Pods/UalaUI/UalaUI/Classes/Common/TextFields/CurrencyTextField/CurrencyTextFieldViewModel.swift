//
//  CurrencyTextFieldViewModel.swift
//  UalaUI
//
//  Created by Mauro Distefano on 23/03/2022.
//

import Foundation

public struct CurrencyTextFieldViewModel {
    let font: UIFont
    let mainColor: UIColor
    let secondaryColor: UIColor
    let placeholderColor: UIColor
    let focusedColor: UIColor
    let errorColor: UIColor
    let textAlignment: NSTextAlignment
    let currencySymbol: String
    let localeIdentifier: String
    let fractionDigits: Int

    public init(font: UIFont,
                mainColor: UIColor,
                secondaryColor: UIColor,
                placeholderColor: UIColor,
                focusedColor: UIColor,
                errorColor: UIColor,
                textAlignment: NSTextAlignment,
                currencySymbol: String,
                localeIdentifier: String,
                fractionDigits: Int) {
        self.font = font
        self.mainColor = mainColor
        self.secondaryColor = secondaryColor
        self.placeholderColor = placeholderColor
        self.focusedColor = focusedColor
        self.errorColor = errorColor
        self.textAlignment = textAlignment
        self.currencySymbol = currencySymbol
        self.localeIdentifier = localeIdentifier
        self.fractionDigits = fractionDigits
    }
}

public extension CurrencyTextFieldViewModel {
    
    static func fareCurrency(fractionDigits: Int = 2) -> CurrencyTextFieldViewModel {
        CurrencyTextFieldViewModel(font: .extraLight(size: 26.0),
                                   mainColor: UalaStyle.colors.grey90,
                                   secondaryColor: UalaStyle.colors.grey50,
                                   placeholderColor: UalaStyle.colors.grey80,
                                   focusedColor: UalaStyle.colors.blue50,
                                   errorColor: UalaStyle.colors.red70,
                                   textAlignment: .left,
                                   currencySymbol: "$",
                                   localeIdentifier: EnvironmentHelper().localeIdentifier,
                                   fractionDigits: fractionDigits)
    }
}
