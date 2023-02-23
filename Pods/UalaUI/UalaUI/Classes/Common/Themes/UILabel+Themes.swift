//
//  UILabel+Themes.swift
//  Uala
//
//  Created by Nelson Domínguez on 30/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public struct LabelStyle {
    
    let font: UIFont
    let textColor: UIColor
    let textAlignment: NSTextAlignment
}

public extension LabelStyle {
    
    // Fare Style System
    static func regularFarePrimaryLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.fareTextMainColor, textAlignment: .left)
    }
    
    static func regularFarePrimaryCenter(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.fareTextMainColor, textAlignment: .center)
    }
    
    static func regularFarePrimaryRight(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.fareTextMainColor, textAlignment: .right)
    }
    
    static func regularFareSecondaryLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.fareTextSecondaryColor, textAlignment: .left)
    }
    
    static func regularFareSecondaryCenter(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.fareTextSecondaryColor, textAlignment: .center)
    }
    
    static func regularFareSecondaryRight(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.fareTextSecondaryColor, textAlignment: .right)
    }
    
    static func semiBoldFarePrimaryLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .semiBold(size: size), textColor: UalaStyle.colors.fareTextMainColor, textAlignment: .left)
    }
    
    static func semiBoldFarePrimaryCenter(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .semiBold(size: size), textColor: UalaStyle.colors.fareTextMainColor, textAlignment: .center)
    }
    
    static func semiBoldFarePrimaryRight(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .semiBold(size: size), textColor: UalaStyle.colors.fareTextMainColor, textAlignment: .right)
    }
    
    static func semiBoldFareSecondaryLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .semiBold(size: size), textColor: UalaStyle.colors.fareTextSecondaryColor, textAlignment: .left)
    }
    
    static func semiBoldFareSecondaryCenter(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .semiBold(size: size), textColor: UalaStyle.colors.fareTextSecondaryColor, textAlignment: .center)
    }
    
    static func semiBoldFareSecondaryRight(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.fareTextSecondaryColor, textAlignment: .right)
    }
    
    static var base: LabelStyle {
        return LabelStyle(font: .regular(size: 17), textColor: UalaStyle.colors.grey90, textAlignment: .left)
    }
    
    static var header: LabelStyle {
        return LabelStyle(font: .regular(size: 22), textColor: UalaStyle.colors.grey90, textAlignment: .center)
    }
    
    static var headerWhite: LabelStyle {
        return LabelStyle(font: .regular(size: 20), textColor: .white, textAlignment: .center)
    }
    
    static var smallHeaderWhite: LabelStyle {
        return LabelStyle(font: .regular(size: 13), textColor: .white, textAlignment: .left)
    }
    
    static var subHeader: LabelStyle {
        return LabelStyle(font: .regular(size: 17), textColor: UalaStyle.colors.grey70, textAlignment: .center)
    }
    
    static var smallSubHeader: LabelStyle {
        return LabelStyle(font: .regular(size: 14), textColor: UalaStyle.colors.grey70, textAlignment: .center)
    }
    
    static var extraSmallsubHeader: LabelStyle {
        return LabelStyle(font: .regular(size: 12), textColor: UalaStyle.colors.grey70, textAlignment: .center)
    }
    
    static var subHeaderWhite: LabelStyle {
        return LabelStyle(font: .regular(size: 17), textColor: .white, textAlignment: .center)
    }
    
    static var subHeaderWhiteLight: LabelStyle {
        return LabelStyle(font: .light(size: 17), textColor: .white, textAlignment: .center)
    }
    
    static var title: LabelStyle {
        return LabelStyle(font: .semiBold(size: 22), textColor: UalaStyle.colors.grey90, textAlignment: .center)
    }
    
    static var whiteTitle: LabelStyle {
        return LabelStyle(font: .semiBold(size: 17), textColor: .white, textAlignment: .left)
    }
    
    static var whiteSubTitle: LabelStyle {
        return LabelStyle(font: .regular(size: 15), textColor: .white, textAlignment: .left)
    }
    
    static var mediumTitle: LabelStyle {
        return LabelStyle(font: .regular(size: 20), textColor: .black, textAlignment: .center)
    }
    
    static var smallTitle: LabelStyle {
        return LabelStyle(font: .regular(size: 17), textColor: UalaStyle.colors.grey90, textAlignment: .center)
    }
    
    static var smallSubtitleWhite: LabelStyle {
        return LabelStyle(font: .regular(size: 14), textColor: .white, textAlignment: .center)
    }
    
    static var smallTitleBlack: LabelStyle {
        return LabelStyle(font: .regular(size: 17), textColor: .black, textAlignment: .left)
    }
    
    static var subtitle: LabelStyle {
        return LabelStyle(font: .regular(size: 14), textColor: UalaStyle.colors.grey90.withAlphaComponent(0.54), textAlignment: .left)
    }
    
    static var subtitleSmall: LabelStyle {
        return LabelStyle(font: .regular(size: 12), textColor: UalaStyle.colors.grey90.withAlphaComponent(0.54), textAlignment: .left)
    }
    
    static var boldTitle: LabelStyle {
        return LabelStyle(font: .semiBold(size: 17), textColor: .black, textAlignment: .left)
    }
    
    static var smallTitleBlue: LabelStyle {
        return LabelStyle(font: .regular(size: 17), textColor: UalaStyle.colors.blue50, textAlignment: .center)
    }
    
    static var cellTitleBlackBold: LabelStyle {
        return LabelStyle(font: .semiBold(size: 16), textColor: .black, textAlignment: .left)
    }
    
    static var cellTitleBlack: LabelStyle {
        return LabelStyle(font: .regular(size: 14), textColor: .black, textAlignment: .left)
    }
    
    static var collectionCellTitleBlack: LabelStyle {
        return LabelStyle(font: .regular(size: 16), textColor: .black, textAlignment: .center)
    }
    
    static var smallCenterWhiteRegular: LabelStyle {
        return LabelStyle(font: .regular(size: 14), textColor: .white, textAlignment: .center)
    }
    
    static var smallCellTitle: LabelStyle {
        return LabelStyle(font: .regular(size: 15), textColor: .black, textAlignment: .left)
    }
    
    static var smallCellSubTitle: LabelStyle {
        return LabelStyle(font: .regular(size: 13), textColor: UalaStyle.colors.grey70, textAlignment: .left)
    }
    
    static var blueTitle: LabelStyle {
        return LabelStyle(font: .regular(size: 20), textColor: UalaStyle.colors.blue50, textAlignment: .left)
    }
    
    static var blackTitle: LabelStyle {
        return LabelStyle(font: .semiBold(size: 22), textColor: UalaStyle.colors.grey90, textAlignment: .left)
    }
    
    static var warmGray: LabelStyle {
        return LabelStyle(font: .regular(size: 15), textColor: UalaStyle.colors.grey70, textAlignment: .left)
    }
    
    static var error: LabelStyle {
        return LabelStyle(font: .regular(size: 13), textColor: UalaStyle.colors.red60, textAlignment: .left)
    }
    
    static func regularError(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.red60, textAlignment: .center)
    }
    
    static var reddishError: LabelStyle {
        return LabelStyle(font: .regular(size: 12), textColor: UalaStyle.colors.red70, textAlignment: .left)
    }
    
    static var regularTitle: LabelStyle {
        return LabelStyle(font: .regular(size: 17), textColor: .black, textAlignment: .left)
    }
    
    static var cellTitleBlackish: LabelStyle {
        return LabelStyle(font: .semiBold(size: 16), textColor: UalaStyle.colors.grey70, textAlignment: .left)
    }
    
    static var collectionCellSubTitle: LabelStyle {
        return LabelStyle(font: .regular(size: 14), textColor: UalaStyle.colors.grey70, textAlignment: .center)
    }
    
    static var pickerText: LabelStyle {
        return LabelStyle(font: .regular(size: 17), textColor: UalaStyle.colors.grey80, textAlignment: .center)
    }
    
    static var pickerTextLeft: LabelStyle {
        return LabelStyle(font: .regular(size: 16), textColor: UalaStyle.colors.grey80, textAlignment: .left)
    }
    
    static var pickerInformationText: LabelStyle {
        return LabelStyle(font: .regular(size: 12), textColor: UalaStyle.colors.blue50, textAlignment: .left)
    }
    
    static func regular(size: CGFloat, color: UIColor, alignment: NSTextAlignment = .left) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: color, textAlignment: alignment)
    }
    
    static func regularWarmGreyLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.grey70, textAlignment: .left)
    }
    
    static func regularWarmGreyTwoLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.grey60, textAlignment: .left)
    }
    
    static func regularWarmGreyThreeLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.grey60, textAlignment: .left)
    }
    
    static func regularWhiteLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: .white, textAlignment: .left)
    }
    
    static func regularWhiteCenter(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: .white, textAlignment: .center)
    }
    
    static func regularBrownishGreyLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.grey80, textAlignment: .left)
    }
    
    static func regularBrownishGreyCenter(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.grey70, textAlignment: .center)
    }
    
    static func regularWarmGreyRight(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.grey70, textAlignment: .right)
    }
    
    static func regularWarmGreyFiveLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.grey70, textAlignment: .left)
    }

    static func regularBlueLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.blue50, textAlignment: .left)
    }
    
    static func regularCoolGreyTwoLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.grey60, textAlignment: .left)
    }
    
    static func regularCornflowerTwoLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.blue40, textAlignment: .left)
    }
    
    static func mediumWarmGreyTwoCenter(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .semiBold(size: size), textColor: UalaStyle.colors.grey60, textAlignment: .center)
    }
    
    static func regularPinkisGreyLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.grey50, textAlignment: .left)
    }
    
    static func regularBlackLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.grey90, textAlignment: .left)
    }
    
    static func regularBlackCenter(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.grey90, textAlignment: .center)
    }
    
    static func regularBlackTwoLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.grey90, textAlignment: .left)
    }
    
    static func regularWarmGreyCenter(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.grey70, textAlignment: .center)
    }
    
    static func mediumBlackishLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .semiBold(size: size), textColor: UalaStyle.colors.grey90, textAlignment: .left)
    }
    
    static func mediumWarmGreyCenter(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .semiBold(size: size), textColor: UalaStyle.colors.grey70, textAlignment: .center)
    }
    
    static func lightWarmGreyCenter(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .light(size: size), textColor: UalaStyle.colors.grey70, textAlignment: .center)
    }
    
    static func regularCoolGreyTwoCenter(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.grey60, textAlignment: .center)
    }
    
    static func regularSilverLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.silverTwo, textAlignment: .left)
    }
    
    static func regularBlueGreyLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.blueGrey, textAlignment: .left)
    }
    
    static func regularSteelLeft(size: CGFloat) -> LabelStyle {
        return LabelStyle(font: .regular(size: size), textColor: UalaStyle.colors.steel, textAlignment: .left)
    }
    
    static var smallSubtitleWithOpacity: LabelStyle {
        return LabelStyle(font: .regular(size: 15), textColor: UalaStyle.colors.darkGrey.withAlphaComponent(0.6), textAlignment: .left)
    }
    
    static var subtitleWithOpacity: LabelStyle {
        return LabelStyle(font: .regular(size: 17), textColor: UalaStyle.colors.darkGrey.withAlphaComponent(0.6), textAlignment: .center)
    }
    
    static var semiBoldSubtitleLeft: LabelStyle {
        return LabelStyle(font: .semiBold(size: 16), textColor: UalaStyle.colors.grey90, textAlignment: .left)
    }
    
    static func semiBold(size: CGFloat, color: UIColor, alignment: NSTextAlignment = .left) -> LabelStyle {
        return LabelStyle(font: .semiBold(size: size), textColor: color, textAlignment: alignment)
    }
    
    static func light(size: CGFloat, color: UIColor, alignment: NSTextAlignment = .left) -> LabelStyle {
        return LabelStyle(font: .light(size: size), textColor: color, textAlignment: alignment)
    }

    static func extraLight(size: CGFloat, color: UIColor, alignment: NSTextAlignment = .left) -> LabelStyle {
        return LabelStyle(font: .extraLight(size: size), textColor: color, textAlignment: alignment)
    }
}

public extension UILabel {
    
    func customize(style: LabelStyle) {
        textColor = style.textColor
        font = style.font
        textAlignment = style.textAlignment
    }
    
    func customize(style: LabelStyle, with attributes: [UalaAttributedString]) {
        customize(style: style)
        setAttributes(elements: attributes)
    }
}

public extension UITextView {
    func customize(style: LabelStyle) {
        textColor = style.textColor
        font = style.font
        textAlignment = style.textAlignment
    }
}
