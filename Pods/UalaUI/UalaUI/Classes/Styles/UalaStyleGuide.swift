//
//  UalaStyleGuide.swift
//  UalaUI
//
//  Created by Christian Correa on 26/02/21.
//

import UIKit
import UalaCore

/// This class contains everything related to Uala styles
public final class UalaStyle {
    
    // MARK: - Color palette
    public static let colors = UalaColor()
    
    // MARK: - Uala Buttons
    public static let buttons = UalaButtonStyles()
    
    // MARK: - Uala Fonts
    public static let font = UalaFontCore()
    
    static func initializeFonts() {
        UalaFontCore.registerFont(withName: UalaFontName.bold.rawValue)
        UalaFontCore.registerFont(withName: UalaFontName.semiBold.rawValue)
        UalaFontCore.registerFont(withName: UalaFontName.medium.rawValue)
        UalaFontCore.registerFont(withName: UalaFontName.regular.rawValue)
        UalaFontCore.registerFont(withName: UalaFontName.light.rawValue)
        UalaFontCore.registerFont(withName: UalaFontName.extraLight.rawValue)
    }
}
