//
//  AccountRouter.swift
//  UalaCore
//
//  Created by Federico Frias on 10/05/2021.
//

import Alamofire

struct AccountRouter: AccountRouteable {
    
    var route: AccountRoute = .account
    
    var path: String {
        switch route {
        case .account, .updateAccount:
            return "/1/users"
        case .features:
            return "/1/user/availablefeatures"
        case .createPin:
            return "1/users/pin"
        case .updateUserEmail:
            return "1/user/email/mfa"
        case .banks:
            return "1/banks"
        }
    }
    
    var mapper: Mappeable {
        switch route {
        case .account:
            return AccountMapper()
        case .features:
            return AccountFeaturesMapper()
        case .updateAccount:
            return UpdateAccountMapper()
        case .createPin:
            return CreatePinMapper()
        case .updateUserEmail:
            return UpdateUserEmail()
        case .banks:
            return AllowedBanksMapper()
        }
    }
    
    var method: HTTPMethod {
        switch route {
        case .updateAccount:
            return .put
        case .createPin:
            return .post
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch route {
        case .createPin:
            return [
               "Content-Type": "application/json",
               "Accept": "application/json"
            ]
        default:
            return nil
        }
    }
    
    var errorMapper: Mappeable {
        switch route {
        case .createPin:
            // Mapper implemented to retrieve the message from backend
            return BEErrorMapper()
        default:
            return ErrorMapper()
        }
    }
    
    var baseUrl: String {
        switch route {
        case .features:
            return String.getConfigurationValue(forKey: .baseUrlRegistration, from: .SignUp)
        default:
            return String.getConfigurationValue(forKey: .baseUrlDebit, from: .Core)
        }
    }
}
