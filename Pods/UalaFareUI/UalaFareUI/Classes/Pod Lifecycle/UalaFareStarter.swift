//
//  UalaFareUIStarter.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 11/07/2022.
//

final class FontLoader {
    private var areFontsLoaded = false
    
    static let shared = FontLoader()
    
    private init() {}
    
    static func loadFontsIfNeeded() {
        if Self.shared.areFontsLoaded {
            return
        }
        UalaFontManager.loadFonts()
        Self.shared.areFontsLoaded = true
    }
}
