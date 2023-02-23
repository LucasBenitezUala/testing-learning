//
//  MexicoABCRouter.swift
//  UalaCore
//
//  Created by Luis Perez on 19/10/21.
//

import Alamofire

struct MexicoACBAccountRouter: AccountRouteable {
    
    var route: AccountRoute = .account
    
    var path: String {
        switch route {
        case .account, .updateAccount:
            return "/1/accounts"
        case .features:
            return "/1/accounts/availablefeatures"
        case .createPin:
            return "1/accounts/pin"
        case .updateUserEmail:
            return "1/user/email/mfa"
        case .banks:
            return ""
        }
    }
    
    var mapper: Mappeable {
        switch route {
        case .account:
            return MexicoAccountMapper()
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
        case .updateAccount, .updateUserEmail:
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
    
    var parameters: Parameters? {
        switch route {
        case .updateUserEmail(let email, let pin, let mfaPin, let mfaPinId):
            return ["email": email,
                    "pin": pin,
                    "mfaPin": mfaPin,
                    "mfaPinId": mfaPinId]
        default:
            return nil
        }
    }
    
    var baseUrl: String {
        switch scheme() {
        case .stage:
            return "https://user-registration.api.stage.bank-debit.mx.ua.la"
        case .test:
            return "https://user-registration.api.test.bank-debit.mx.ua.la"
        case .develop:
            return "https://user-registration.api.dev.bank-debit.mx.ua.la"
        case .production:
            return "https://user-registration.api.bank-debit.mx.ua.la"
        }
    }
}
