struct ArgentinaAccountRouter: AccountRouteable {
        
    var route: AccountRoute = .account
    
    var path: String {
        switch route {
        case .account, .updateAccount:
            return "/1/accounts"
        case .features:
            return "/4/accounts/availablefeatures"
        case .createPin, .updateUserEmail, .banks:
            return ""
        }
    }
    
    var mapper: Mappeable {
        switch route {
        case .account, .updateAccount:
            return ArgAccountMapper()
        case .features:
            return AccountFeaturesMapper()
        case .createPin:
            return CreatePinMapper()
        case .updateUserEmail:
            return UpdateUserEmail()
        case .banks:
            return AllowedBanksMapper()
        }
    }
}
