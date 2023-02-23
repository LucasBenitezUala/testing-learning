import UIKit

public protocol SpacingsProtocol {
    var value: CGFloat { get }
}

public enum Spacings: String, SpacingsProtocol, CaseIterable {

    private static let spacing1Value: CGFloat = 4.0
    private static let spacing2Value: CGFloat = 8.0
    private static let spacing3Value: CGFloat = 12.0
    private static let spacing4Value: CGFloat = 16.0
    private static let spacing5Value: CGFloat = 24.0
    private static let spacing6Value: CGFloat = 32.0
    private static let spacing7Value: CGFloat = 40.0
    private static let spacing8Value: CGFloat = 56.0
    private static let spacingBaseValue: CGFloat = 16.0
    private static let spacingNoneValue: CGFloat = 0.0

    case spacing1 
    case spacing2 
    case spacing3 
    case spacing4 
    case spacing5 
    case spacing6 
    case spacing7 
    case spacing8 
    case spacingBase 
    case spacingNone 

    public var value: CGFloat {
        switch self {
        case .spacing1:
            return Spacings.spacing1Value
        case .spacing2:
            return Spacings.spacing2Value
        case .spacing3:
            return Spacings.spacing3Value
        case .spacing4:
            return Spacings.spacing4Value
        case .spacing5:
            return Spacings.spacing5Value
        case .spacing6:
            return Spacings.spacing6Value
        case .spacing7:
            return Spacings.spacing7Value
        case .spacing8:
            return Spacings.spacing8Value
        case .spacingBase:
            return Spacings.spacingBaseValue
        case .spacingNone:
            return Spacings.spacingNoneValue
        }
    }
}
