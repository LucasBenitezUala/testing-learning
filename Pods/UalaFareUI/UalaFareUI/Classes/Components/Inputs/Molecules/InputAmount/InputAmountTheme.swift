//
//  InputAmountTheme.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 03/08/2022.
//

public protocol InputAmountTheme {
    var title: InputTitle? { get }
    var helperTheme: InputHelperTheme { get }
    var amountFieldTheme: AmountFieldTheme { get }
    var helperText: String? { get }
    var helperType: InputHelperType? { get }
}

struct DefaultInputAmountTheme: InputAmountTheme {
    var title: InputTitle?
    var helperTheme: InputHelperTheme
    var amountFieldTheme: AmountFieldTheme
    var helperText: String?
    var helperType: InputHelperType?
}
