protocol ThemeableColors {
    static var primaryLight: String { get }
    static var primaryDefault: String { get }
    static var primaryDark: String { get }
    static var primaryDarker: String { get }
    static var primaryLighter: String { get }
    static var bgLight: String { get }
    static var neutralWhite: String { get }
    static var neutralLighter: String { get }
    static var neutralLight: String { get }
    static var neutralMiddle: String { get }
    static var neutralDark: String { get }
    static var neutralDarker: String { get }
    static var accentLight: String { get }
    static var accentMiddle: String { get }
    static var accentDark: String { get }
    static var errorLight: String { get }
    static var errorMiddle: String { get }
    static var errorDark: String { get }
    static var successLight: String { get }
    static var successMiddle: String { get }
    static var successDark: String { get }
    static var warningLight: String { get }
    static var warningMiddle: String { get }
    static var warningDark: String { get }
    static var informationLight: String { get }
    static var informationMiddle: String { get }
    static var informationDark: String { get }
    static var brandCoral: String { get }
    static var brandBlue: String { get }
}

public enum ThemedColors: CaseIterable {
    case primaryLight
    case primaryDefault
    case primaryDark
    case primaryDarker
    case primaryLighter
    case bgLight
    case neutralWhite
    case neutralLighter
    case neutralLight
    case neutralMiddle
    case neutralDark
    case neutralDarker
    case accentLight
    case accentMiddle
    case accentDark
    case errorLight
    case errorMiddle
    case errorDark
    case successLight
    case successMiddle
    case successDark
    case warningLight
    case warningMiddle
    case warningDark
    case informationLight
    case informationMiddle
    case informationDark
    case brandCoral
    case brandBlue
}

extension ThemeableColors {

    public static func color(for color: ThemedColors) -> UIColor {
        return UIColor(hex: self.hex(for: color))
    }
     
    // swiftlint:disable function_body_length
    public static func hex(for color: ThemedColors) -> String {
        switch color {
        case .primaryLight:
            return Self.primaryLight
            
        case .primaryDefault:
            return Self.primaryDefault
            
        case .primaryDark:
            return Self.primaryDark
            
        case .primaryDarker:
            return Self.primaryDarker
            
        case .primaryLighter:
            return Self.primaryLighter
            
        case .bgLight:
            return Self.bgLight
            
        case .neutralWhite:
            return Self.neutralWhite
            
        case .neutralLighter:
            return Self.neutralLighter
            
        case .neutralLight:
            return Self.neutralLight
            
        case .neutralMiddle:
            return Self.neutralMiddle
            
        case .neutralDark:
            return Self.neutralDark
            
        case .neutralDarker:
            return Self.neutralDarker
            
        case .accentLight:
            return Self.accentLight
            
        case .accentMiddle:
            return Self.accentMiddle
            
        case .accentDark:
            return Self.accentDark
            
        case .errorLight:
            return Self.errorLight
            
        case .errorMiddle:
            return Self.errorMiddle
            
        case .errorDark:
            return Self.errorDark
            
        case .successLight:
            return Self.successLight
            
        case .successMiddle:
            return Self.successMiddle
            
        case .successDark:
            return Self.successDark
            
        case .warningLight:
            return Self.warningLight
            
        case .warningMiddle:
            return Self.warningMiddle
            
        case .warningDark:
            return Self.warningDark
            
        case .informationLight:
            return Self.informationLight
            
        case .informationMiddle:
            return Self.informationMiddle
            
        case .informationDark:
            return Self.informationDark
            
        case .brandCoral:
            return Self.brandCoral
            
        case .brandBlue:
            return Self.brandBlue
            
        }
    }
}
