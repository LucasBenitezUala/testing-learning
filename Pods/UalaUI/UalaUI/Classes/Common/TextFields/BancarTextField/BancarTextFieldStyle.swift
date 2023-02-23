//
//  BancarTextFieldStyle.swift
//  Uala
//
//  Created by Nicolas on 30/07/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation

public struct BancarTextFieldStyle {
    
    let font: UIFont
    let tintColor: UIColor
    let textColor: UIColor
    let placeholderColor: UIColor
    let placeholderActiveColor: UIColor
    let textAlignment: NSTextAlignment
    let placeholderActiveFont: UIFont
    let lineColor: UIColor
    let activeLineColor: UIColor
    let currencySignColor: UIColor = UalaStyle.colors.blue50
}

public extension BancarTextFieldStyle {
    
    static var fareText: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 16),
            tintColor: UalaStyle.colors.grey90,
            textColor: UalaStyle.colors.grey90,
            placeholderColor: UalaStyle.colors.grey60,
            placeholderActiveColor: UalaStyle.colors.blue50,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 12),
            lineColor: UalaStyle.colors.grey50,
            activeLineColor: UalaStyle.colors.blue50
        )
    }
    
    static var fareCurrency: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 35),
            tintColor: UalaStyle.colors.grey90,
            textColor: UalaStyle.colors.grey90,
            placeholderColor: UalaStyle.colors.grey60,
            placeholderActiveColor: UalaStyle.colors.blue50,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 35),
            lineColor: UalaStyle.colors.grey90,
            activeLineColor: UalaStyle.colors.blue50)
    }

    @available(*, deprecated, message: "currency does not match fare design. Use fareCurrency instead")
    static var currency: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 35),
            tintColor: UalaStyle.colors.steel,
            textColor: UalaStyle.colors.steel,
            placeholderColor: UalaStyle.colors.steel,
            placeholderActiveColor: UalaStyle.colors.blue40,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 35),
            lineColor: UalaStyle.colors.steel,
            activeLineColor: UalaStyle.colors.blue50)
    }
    
    @available(*, deprecated, message: "warmGray does not match fare design. Use fareText instead")
    static var warmGray: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 16),
            tintColor: UalaStyle.colors.grey60,
            textColor: UalaStyle.colors.grey60,
            placeholderColor: UalaStyle.colors.grey60,
            placeholderActiveColor: UalaStyle.colors.grey60,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 12),
            lineColor: UalaStyle.colors.grey60,
            activeLineColor: UalaStyle.colors.cornflower
        )
    }

    static var black: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 17),
            tintColor: .black,
            textColor: .black,
            placeholderColor: UalaStyle.colors.steel,
            placeholderActiveColor: UalaStyle.colors.steel,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 12),
            lineColor: .black,
            activeLineColor: .black
        )
    }
    
    static var white: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 35),
            tintColor: .white,
            textColor: .white,
            placeholderColor: .white,
            placeholderActiveColor: .white,
            textAlignment: .center,
            placeholderActiveFont: .regular(size: 35),
            lineColor: .white,
            activeLineColor: .white
        )
    }
    
    @available(*, deprecated, message: "steel does not match fare design. Use fareText instead")
    static var steel: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 17),
            tintColor: UalaStyle.colors.steel,
            textColor: UalaStyle.colors.steel,
            placeholderColor: UalaStyle.colors.steel,
            placeholderActiveColor: UalaStyle.colors.steel,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 12),
            lineColor: UalaStyle.colors.steel,
            activeLineColor: UalaStyle.colors.blue50
        )
    }
    
    @available(*, deprecated, message: "steelBlueActive does not match fare design. Use fareText instead")
    static var steelBlueActive: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 17),
            tintColor: UalaStyle.colors.steel,
            textColor: UalaStyle.colors.steel,
            placeholderColor: UalaStyle.colors.steel,
            placeholderActiveColor: UalaStyle.colors.blue40,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 12),
            lineColor: UalaStyle.colors.steel,
            activeLineColor: UalaStyle.colors.blue50
        )
    }
    
    static var error: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 17),
            tintColor: UalaStyle.colors.fareTextErrorColor,
            textColor: UalaStyle.colors.fareTextErrorColor,
            placeholderColor: UalaStyle.colors.fareTextErrorColor,
            placeholderActiveColor: UalaStyle.colors.fareTextErrorColor,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 12),
            lineColor: UalaStyle.colors.fareTextErrorColor,
            activeLineColor: UalaStyle.colors.blue50
        )
    }
    
    static var disableText: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 16),
            tintColor: UalaStyle.colors.grey60,
            textColor: UalaStyle.colors.grey60,
            placeholderColor: UalaStyle.colors.grey60,
            placeholderActiveColor: UalaStyle.colors.grey60,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 12),
            lineColor: UalaStyle.colors.grey60,
            activeLineColor: UalaStyle.colors.grey60
        )
    }
}
