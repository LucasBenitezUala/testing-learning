//
//  DefaultThemes.swift
//  UalaDSDemo
//
//  Created by Luis Perez on 29/06/22.
//

public enum AvailableThemes {
    case light
    case dark
    
    var theme: Theme {
        switch self {
        case .light:
            return LightTheme()
        case .dark:
            return DarkTheme()
        }
    }
}
