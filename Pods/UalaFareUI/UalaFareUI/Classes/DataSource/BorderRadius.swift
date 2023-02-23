public protocol BorderRadiusProtocol {
    var value: String { get }
}

public enum BorderRadius: BorderRadiusProtocol, CaseIterable {

    private static let radiiSmValue: String = "4"
    private static let radiiMdValue: String = "8"
    private static let radiiLgValue: String = "24"
    private static let radiiFullValue: String = "100%"
    private static let radiiNoneValue: String = "0"

    case radiiSm 
    case radiiMd 
    case radiiLg 
    case radiiFull 
    case radiiNone 

    public var value: String {
        switch self {
        case .radiiSm:
            return BorderRadius.radiiSmValue
        case .radiiMd:
            return BorderRadius.radiiMdValue
        case .radiiLg:
            return BorderRadius.radiiLgValue
        case .radiiFull:
            return BorderRadius.radiiFullValue
        case .radiiNone:
            return BorderRadius.radiiNoneValue
        }
    }
}
