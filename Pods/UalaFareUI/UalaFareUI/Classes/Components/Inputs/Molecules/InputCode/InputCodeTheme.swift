//
//  InputCodeTheme.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 22/08/2022.
//

public protocol InputCodeTheme {
    var codeFieldTheme: CodeFieldTheme { get }
    var helperTheme: InputHelperTheme { get }
    var helperText: String? { get }
    var helperType: InputHelperType? { get }
}

struct DefaultInputCodeTheme: InputCodeTheme {
    var codeFieldTheme: CodeFieldTheme
    var helperTheme: InputHelperTheme
    var helperText: String?
    var helperType: InputHelperType?
}
