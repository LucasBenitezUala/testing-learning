import UIKit

public protocol TypographyStyleProtocol {
    var attributes: TypographyStyleAttributes { get }
}

public struct TypographyStyleAttributes {
    public let fontFamily: FontFamily
    public let fontWeight: FontWeights
    public let fontSize: FontSizes
    public let lineHeight: LineHeights
    public let letterSpacing: LetterSpacing
    public let textCase: TextCase
}
// swiftlint:disable type_body_length
final class TypographyStyleAttributeProvider {
    // swiftlint:disable function_body_length
    static func attributes(for style: TypographyStyle) -> TypographyStyleAttributes {
        switch style {
        case .bodyLgRegular:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightRegular,
              fontSize: .fontSize4,
              lineHeight: .lineHeightTall,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .bodyLgBold:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightBold,
              fontSize: .fontSize4,
              lineHeight: .lineHeightTall,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .bodyMdRegular:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightRegular,
              fontSize: .fontSize3,
              lineHeight: .lineHeightTall,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .bodyMdBold:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightBold,
              fontSize: .fontSize3,
              lineHeight: .lineHeightTall,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .bodySmRegular:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightRegular,
              fontSize: .fontSize2,
              lineHeight: .lineHeightTall,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .bodySmBold:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightBold,
              fontSize: .fontSize2,
              lineHeight: .lineHeightTall,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .labelLgRegular:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightRegular,
              fontSize: .fontSize5,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .labelLgBold:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightBold,
              fontSize: .fontSize5,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .labelMdRegular:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightRegular,
              fontSize: .fontSize3,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .labelMdBold:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightBold,
              fontSize: .fontSize3,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .labelSmRegular:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightRegular,
              fontSize: .fontSize2,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .labelSmBold:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightBold,
              fontSize: .fontSize2,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .buttonLgRegular:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightRegular,
              fontSize: .fontSize4,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .buttonMdRegular:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightRegular,
              fontSize: .fontSize3,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .buttonMdBold:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightBold,
              fontSize: .fontSize3,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .buttonSmRegular:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightRegular,
              fontSize: .fontSize1,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .buttonSmBold:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightBold,
              fontSize: .fontSize1,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .numberLgLight:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightLight,
              fontSize: .fontSize7,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .numberLgBold:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightBold,
              fontSize: .fontSize7,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .numberMdLight:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightLight,
              fontSize: .fontSize6,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone
            )
           
        case .numberMdRegular:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightRegular,
              fontSize: .fontSize6,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone)
           
        case .numberSmBold:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightBold,
              fontSize: .fontSize5,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone)
           
        case .titleLg:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightBold,
              fontSize: .fontSize6,
              lineHeight: .lineHeightBase,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone)
           
        case .titleMd:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightBold,
              fontSize: .fontSize5,
              lineHeight: .lineHeightBase,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone)
           
        case .titleSm:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightBold,
              fontSize: .fontSize4,
              lineHeight: .lineHeightBase,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone)
           
        case .titleXs:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightBold,
              fontSize: .fontSize3,
              lineHeight: .lineHeightBase,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone)
           
        case .headingSm:
            return TypographyStyleAttributes(
              fontFamily: .fontFamilyPrimary,
              fontWeight: .fontWeightRegular,
              fontSize: .fontSize5,
              lineHeight: .lineHeightNormal,
              letterSpacing: .letterSpacingNormal,
              textCase: .textCaseNone)
        }
    }
}

public enum TypographyStyle: TypographyStyleProtocol, CaseIterable {
    case bodyLgRegular 
    case bodyLgBold 
    case bodyMdRegular 
    case bodyMdBold 
    case bodySmRegular 
    case bodySmBold 
    case labelLgRegular 
    case labelLgBold 
    case labelMdRegular 
    case labelMdBold 
    case labelSmRegular 
    case labelSmBold 
    case buttonLgRegular 
    case buttonMdRegular 
    case buttonMdBold 
    case buttonSmRegular 
    case buttonSmBold 
    case numberLgLight 
    case numberLgBold 
    case numberMdLight 
    case numberMdRegular 
    case numberSmBold 
    case titleLg 
    case titleMd 
    case titleSm 
    case titleXs 
    case headingSm 

    public var attributes: TypographyStyleAttributes {
        FontLoader.loadFontsIfNeeded()
        return TypographyStyleAttributeProvider.attributes(for: self)
    }
}
