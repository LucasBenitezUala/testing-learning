//
//  UalaFont.swift
//  UalaDSDemo
//
//  Created by Matías Schwalb on 14/06/2022.
//

import CoreText
import Foundation

class UalaFontManager {
    
    public static func loadFonts() {
        FontFamily.allCases.forEach { family in
            FontWeights.allCases.forEach { weight in
                UalaFontManager.loadFont(withName: family.value + "-" + weight.value)
            }
        }
    }
    
    static func loadFont(withName filenameString: String, fileExtension: String = "ttf") {
        
        let bundle = Bundle(for: Self.self)
        
        guard let resourceBundleURL = bundle.url(forResource: "UalaFareUIFonts", withExtension: "bundle") else {
            print("UalaFareUIFonts: Failed to register font \(filenameString) - Resource bundle URL UalaFareUIFonts could not be loaded.")
            return
        }
        
        guard let resourceBundle = Bundle(url: resourceBundleURL) else {
            print("UalaFareUIFonts: Failed to register font \(filenameString) - Resource bundle UalaFareUIFonts could not be loaded from URL \(resourceBundleURL.absoluteString).")
            return
        }
        
        guard let pathForResourceString = resourceBundle.path(forResource: filenameString, ofType: fileExtension) else {
            print("UalaFareUIFonts: Failed to register font \(filenameString) - Resource bundle path UalaFareUIFonts could not be loaded.")
            return
        }

        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            print("UalaFareUIFonts: Failed to register font \(filenameString) - font data could not be loaded.")
            return
        }

        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("UalaFareUIFonts: Failed to register font \(filenameString) - data provider could not be loaded.")
            return
        }

        guard let font = CGFont(dataProvider) else {
            print("UalaFareUIFonts: Failed to register font \(filenameString) - font could not be loaded.")
            return
        }

        var errorRef: Unmanaged<CFError>? = nil
        if CTFontManagerRegisterGraphicsFont(font, &errorRef) == false {
            print("UalaFareUIFonts: Failed to register font \(filenameString) - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }
}

extension UIFont {
    public convenience init?(family: FontFamily, weight: FontWeights, size: FontSizes) {
        let fontName: String = family.value + "-" + weight.value
        self.init(name: fontName, size: size.rawValue)
    }
}
