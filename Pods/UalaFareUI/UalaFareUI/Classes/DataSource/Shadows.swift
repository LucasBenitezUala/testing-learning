import CoreGraphics

public struct ShadowAttributes {
    let color: UIColor
    let xCoordinate: CGFloat
    let yCoordinate: CGFloat
    let blur: CGFloat
    let spread: CGFloat
}

protocol ShadowsProtocol {
    var attributes: ShadowAttributes { get }
}

public enum Shadows: ShadowsProtocol, CaseIterable {
    
    case shadowSm
    case shadowMd
    case shadowLg
    case glowSm
    
    public var attributes: ShadowAttributes {
        switch self {
        case .shadowSm:
            return ShadowAttributes(
                color: MainThemeManager.shared.globalColor(for: .paletteGrey70).withAlphaComponent(0.3),
                xCoordinate: 0,
                yCoordinate: 2,
                blur: 8,
                spread: 0)
            
        case .shadowMd:
            return ShadowAttributes(
                color: MainThemeManager.shared.globalColor(for: .paletteGrey70),
                xCoordinate: 0,
                yCoordinate: 4,
                blur: 16,
                spread: 0)
            
        case .shadowLg:
            return ShadowAttributes(
                color: MainThemeManager.shared.globalColor(for: .paletteGrey70).withAlphaComponent(0.3),
                xCoordinate: 0,
                yCoordinate: 8,
                blur: 32,
                spread: 0)
            
        case .glowSm:
            return ShadowAttributes(
                color: MainThemeManager.shared.globalColor(for: .paletteBlue05),
                xCoordinate: 0,
                yCoordinate: 0,
                blur: 32,
                spread: 10)
        }
    }
}
