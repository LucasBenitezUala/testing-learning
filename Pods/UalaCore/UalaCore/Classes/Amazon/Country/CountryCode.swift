import Foundation

public enum CountryCode: String {
    case AR, MX, CO, MXABC, ARGBANK
    
    public var environment: CountryEnvironment {
        switch self {
        case .AR:
            return .Argentina
        case .MX:
            if ApplicationConfiguration.current() == .production {
                return .MexicoABC
            } else {
                return .Mexico
            }
        case .CO:
            return .Colombia
        case .MXABC:
            return .MexicoABC
        case .ARGBANK:
            return .ArgentinaBank
        }
    }
}
