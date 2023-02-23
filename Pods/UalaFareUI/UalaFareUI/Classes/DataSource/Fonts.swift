import UIKit

public protocol FontFamilyProtocol {
    var value: String { get }
}

public enum FontFamily: FontFamilyProtocol, CaseIterable {

    private static let fontFamilyPrimaryValue: String = "PublicSans"
    private static let fontFamilySecondaryValue: String = "SofiaPro"

    case fontFamilyPrimary 
    case fontFamilySecondary 

    public var value: String {
        switch self {
        case .fontFamilyPrimary:
            return FontFamily.fontFamilyPrimaryValue
        case .fontFamilySecondary:
            return FontFamily.fontFamilySecondaryValue
        }
    }
}

public protocol FontWeightsProtocol {
    var value: String { get }
}

public enum FontWeights: FontWeightsProtocol, CaseIterable {

    private static let fontWeightLightValue: String = "ExtraLight"
    private static let fontWeightRegularValue: String = "Regular"
    private static let fontWeightBoldValue: String = "SemiBold"

    case fontWeightLight 
    case fontWeightRegular 
    case fontWeightBold 

    public var value: String {
        switch self {
        case .fontWeightLight:
            return FontWeights.fontWeightLightValue
        case .fontWeightRegular:
            return FontWeights.fontWeightRegularValue
        case .fontWeightBold:
            return FontWeights.fontWeightBoldValue
        }
    }
}

public protocol LetterSpacingProtocol {
    var value: CGFloat { get }
}

public enum LetterSpacing: LetterSpacingProtocol, CaseIterable {

    private static let letterSpacingTightValue: CGFloat = -0.2
    private static let letterSpacingNormalValue: CGFloat = 0.0

    case letterSpacingTight 
    case letterSpacingNormal 

    public var value: CGFloat {
        switch self {
        case .letterSpacingTight:
            return LetterSpacing.letterSpacingTightValue
        case .letterSpacingNormal:
            return LetterSpacing.letterSpacingNormalValue
        }
    }
}

public protocol LineHeightsProtocol {
    var value: String { get }
}

public enum LineHeights: LineHeightsProtocol, CaseIterable {

    private static let lineHeightNoneValue: String = "0"
    private static let lineHeightNormalValue: String = "100%"
    private static let lineHeightBaseValue: String = "120%"
    private static let lineHeightTallValue: String = "140%"

    case lineHeightNone 
    case lineHeightNormal 
    case lineHeightBase 
    case lineHeightTall 

    public var value: String {
        switch self {
        case .lineHeightNone:
            return LineHeights.lineHeightNoneValue
        case .lineHeightNormal:
            return LineHeights.lineHeightNormalValue
        case .lineHeightBase:
            return LineHeights.lineHeightBaseValue
        case .lineHeightTall:
            return LineHeights.lineHeightTallValue
        }
    }
}

public protocol FontSizesProtocol {
    var value: CGFloat { get }
}

public enum FontSizes: CGFloat, CaseIterable {

    case fontSize1 = 10.0
    case fontSize2 = 12.0
    case fontSize3 = 14.0
    case fontSize4 = 16.0
    case fontSize5 = 18.0
    case fontSize6 = 22.0
    case fontSize7 = 34.0
}

public enum TextCase {

    case textCaseUpper 
    case textCaseLower 
    case textCaseCapitalize 
    case textCaseNone 
}
