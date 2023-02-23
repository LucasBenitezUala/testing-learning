import Auth0

extension AuthenticationError {
    public var isMultifactorAssociationRequired: Bool {
        return self.description == "association_required"
    }
    
    public var isAccountNotVerified: Bool {
        return self.description == "Please verify your email before logging in."
    }
    
    public var isTokenExpired: Bool {
        return self.description == "expired_token"
    }
    
    public var secondLoginDenied: Bool {
        return self.description == AuthConstants.secondLoginDenied
    }

    public var isOutdatedAppVersion: Bool {
        return self.description == AuthConstants.outdatedAppVersionDescription
    }

    public var isAccountBlocked: Bool {
        return self.code == AuthConstants.blockedAccountCode && self.description == AuthConstants.blockedAccountDescription
    }
}
