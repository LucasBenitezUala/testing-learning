import UIKit

public protocol BorderWidthProtocol {
    var value: CGFloat { get }
}

public enum BorderWidth: BorderWidthProtocol, CaseIterable {

    private static let borderWidthThinValue: CGFloat = 1.0
    private static let borderWidthMediumValue: CGFloat = 2.0
    private static let borderWidthStrongValue: CGFloat = 4.0

    case borderWidthThin 
    case borderWidthMedium 
    case borderWidthStrong 

    public var value: CGFloat {
        switch self {
        case .borderWidthThin:
            return BorderWidth.borderWidthThinValue
        case .borderWidthMedium:
            return BorderWidth.borderWidthMediumValue
        case .borderWidthStrong:
            return BorderWidth.borderWidthStrongValue
        }
    }
}
