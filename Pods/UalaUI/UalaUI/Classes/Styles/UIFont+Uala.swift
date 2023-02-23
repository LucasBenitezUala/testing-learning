//
//  UIFont+Uala.swift
//  UalaUI
//
//  Created by Christian Correa on 05/08/21.
//

import Foundation
import UalaCore
import UIKit

public enum UalaFontBase: CGFloat {
    case h1 = 32
    case h2 = 24
    case h3 = 22
    case headline = 20
    case body = 16
    case captionOne = 14
    case captionTwo = 12
    case label = 10
    
    var adaptativeValue: CGFloat {
        switch self {
        case .captionTwo:
            let lowFont: CGFloat = 10
            return UIDevice.isLowerResolutionDevice ? lowFont : self.rawValue
        default:
            return self.rawValue
        }
    }
}

public enum UalaFontName: String {
    case bold = "PublicSans-Bold"
    case semiBold = "PublicSans-SemiBold"
    case medium = "PublicSans-Medium"
    case regular = "PublicSans-Regular"
    case light = "PublicSans-Light"
    case extraLight = "PublicSans-ExtraLight"
}

public struct UalaFontCore {
    
    public func regular(withSize size: CGFloat) -> UIFont {
        return UalaFontCore.font(size, style: .regular)
    }
    
    public func semiBold(withSize size: CGFloat) -> UIFont {
        return UalaFontCore.font(size, style: .semiBold)
    }
    
    public func bold(withSize size: CGFloat) -> UIFont {
        return UalaFontCore.font(size, style: .bold)
    }
    
    public func light(withSize size: CGFloat) -> UIFont {
        return UalaFontCore.font(size, style: .light)
    }
    
    public func extraLight(withSize size: CGFloat) -> UIFont {
        return UalaFontCore.font(size, style: .extraLight)
    }
    
    public func medium(withSize size: CGFloat) -> UIFont {
        return UalaFontCore.font(size, style: .medium)
    }
    
    // MARK: - H1 font
    public var h1Regular: UIFont {
        return UalaFontCore.font(.h1, style: .regular)
    }
    
    public var h1SemiBold: UIFont {
        return UalaFontCore.font(.h1, style: .semiBold)
    }
    
    public var h1Bold: UIFont {
        return UalaFontCore.font(.h1, style: .bold)
    }
    
    public var h1Light: UIFont {
        return UalaFontCore.font(.h1, style: .light)
    }
    
    public var h1ExtraLight: UIFont {
        return UalaFontCore.font(.h1, style: .extraLight)
    }
    
    public var h1Medium: UIFont {
        return UalaFontCore.font(.h1, style: .medium)
    }
    
    // MARK: - H2 font
    public var h2Regular: UIFont {
        return UalaFontCore.font(.h2, style: .regular)
    }
    
    public var h2SemiBold: UIFont {
        return UalaFontCore.font(.h2, style: .semiBold)
    }
    
    public var h2Bold: UIFont {
        return UalaFontCore.font(.h2, style: .bold)
    }
    
    public var h2Light: UIFont {
        return UalaFontCore.font(.h2, style: .light)
    }
    
    public var h2ExtraLight: UIFont {
        return UalaFontCore.font(.h2, style: .extraLight)
    }
    
    public var h2Medium: UIFont {
        return UalaFontCore.font(.h2, style: .medium)
    }
    
    // MARK: - Headline font
    public var headlineRegular: UIFont {
        return UalaFontCore.font(.headline, style: .regular)
    }
    
    public var headlineSemiBold: UIFont {
        return UalaFontCore.font(.headline, style: .semiBold)
    }
    
    public var headlineBold: UIFont {
        return UalaFontCore.font(.headline, style: .bold)
    }
    
    public var headlineLight: UIFont {
        return UalaFontCore.font(.headline, style: .light)
    }
    
    public var headlineExtraLight: UIFont {
        return UalaFontCore.font(.headline, style: .extraLight)
    }
    
    public var headlineMedium: UIFont {
        return UalaFontCore.font(.headline, style: .medium)
    }
    
    // MARK: - Body font
    public var bodyRegular: UIFont {
        return UalaFontCore.font(.body, style: .regular)
    }
    
    public var bodySemiBold: UIFont {
        return UalaFontCore.font(.body, style: .semiBold)
    }
    
    public var bodyBold: UIFont {
        return UalaFontCore.font(.body, style: .bold)
    }
    
    public var bodyLight: UIFont {
        return UalaFontCore.font(.body, style: .light)
    }
    
    public var bodyExtraLight: UIFont {
        return UalaFontCore.font(.body, style: .extraLight)
    }
    
    public var bodyMedium: UIFont {
        return UalaFontCore.font(.body, style: .medium)
    }
    
    // MARK: - Caption One font
    public var captionOneRegular: UIFont {
        return UalaFontCore.font(.captionOne, style: .regular)
    }
    
    public var captionOneSemiBold: UIFont {
        return UalaFontCore.font(.captionOne, style: .semiBold)
    }
    
    public var captionOneBold: UIFont {
        return UalaFontCore.font(.captionOne, style: .bold)
    }
    
    public var captionOneLight: UIFont {
        return UalaFontCore.font(.captionOne, style: .light)
    }
    
    public var captionOneExtraLight: UIFont {
        return UalaFontCore.font(.captionOne, style: .extraLight)
    }
    
    public var captionOneMedium: UIFont {
        return UalaFontCore.font(.captionOne, style: .medium)
    }
    
    // MARK: - Caption Two font
    public var captionTwoRegular: UIFont {
        return UalaFontCore.font(.captionTwo, style: .regular)
    }
    
    public var captionTwoSemiBold: UIFont {
        return UalaFontCore.font(.captionTwo, style: .semiBold)
    }
    
    public var captionTwoBold: UIFont {
        return UalaFontCore.font(.captionTwo, style: .bold)
    }
    
    public var captionTwoLight: UIFont {
        return UalaFontCore.font(.captionTwo, style: .light)
    }
    
    public var captionTwoExtraLight: UIFont {
        return UalaFontCore.font(.captionTwo, style: .extraLight)
    }
    
    public var captionTwoMedium: UIFont {
        return UalaFontCore.font(.captionTwo, style: .medium)
    }
    
    // MARK: - Label font
    public var labelRegular: UIFont {
        return UalaFontCore.font(.label, style: .regular)
    }
    
    public var labelSemiBold: UIFont {
        return UalaFontCore.font(.label, style: .semiBold)
    }
    
    public var labelBold: UIFont {
        return UalaFontCore.font(.label, style: .bold)
    }
    
    public var labelLight: UIFont {
        return UalaFontCore.font(.label, style: .light)
    }
    
    public var labelExtraLight: UIFont {
        return UalaFontCore.font(.label, style: .extraLight)
    }
    
    public var labelMedium: UIFont {
        return UalaFontCore.font(.label, style: .medium)
    }
}

public extension UalaFontCore {
    
    static func font(_ font: UalaFontBase, style: UalaFontName) -> UIFont {
        
        let cuponStorefont = UIFont(name: style.rawValue, size: font.rawValue)
        return cuponStorefont ?? UalaFontCore.defaultFont(size: font.rawValue)
    }
    
    static func font(_ fontSize: CGFloat, style: UalaFontName) -> UIFont {
        
        let cuponStorefont = UIFont(name: style.rawValue, size: fontSize)
        return cuponStorefont ?? UalaFontCore.defaultFont(size: fontSize)
    }
    
    private static func defaultFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
}

extension UalaFontCore {
    static func registerFont(withName filenameString: String, fileExtension: String = "ttf") {
        let bundle = BundleUtils.getBundle(from: .Common)
        
        guard let pathForResourceString = bundle.path(forResource: filenameString, ofType: fileExtension) else {
            print("UIFont+Uala: Failed to register font \(filenameString) - path for resource not found.")
            return
        }

        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            print("UIFont+Uala: Failed to register font \(filenameString) - font data could not be loaded.")
            return
        }

        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("UIFont+Uala: Failed to register font \(filenameString) - data provider could not be loaded.")
            return
        }

        guard let font = CGFont(dataProvider) else {
            print("UIFont+Uala: Failed to register font \(filenameString) - font could not be loaded.")
            return
        }

        var errorRef: Unmanaged<CFError>?
        if CTFontManagerRegisterGraphicsFont(font, &errorRef) == false {
            print("UIFont+Uala: Failed to register font \(filenameString) - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }
}
