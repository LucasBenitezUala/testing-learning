import Auth0

extension CredentialsManagerError {
    public var isInusualBehaviour: Bool {
        switch self {
        case .failedRefresh(let refreshError):
            return refreshError.localizedDescription == "REFRESH_TOKEN_UNUSUAL_BEHAVIOR_GEOIP"
        default:
            return false
        }
    }
}
