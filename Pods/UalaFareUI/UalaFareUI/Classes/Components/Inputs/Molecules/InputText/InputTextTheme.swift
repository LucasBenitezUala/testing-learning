//
//  InputTextTheme.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 22/07/2022.
//

public protocol InputTextTheme {
    var helperTheme: InputHelperTheme { get }
    var textFieldTheme: TextFieldTheme { get }
    var title: InputTitle? { get }
    var helperText: String? { get }
    var helperType: InputHelperType? { get }
}

struct DefaultInputTextTheme: InputTextTheme {
    var helperTheme: InputHelperTheme
    var title: InputTitle?
    var textFieldTheme: TextFieldTheme
    var helperText: String?
    var helperType: InputHelperType?
}
