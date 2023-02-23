//
//  AcquiringRouter.swift
//  UalaCore
//
//  Created by Diego Palomares on 08/11/21.
//

import Alamofire

struct AcquiringAccountRouter: AcquiringAccountRoutable {
    
    var route: AcquiringAccountRoute = .account
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var parameters: Parameters? {
        if case let .refund(transactionId) = route {
            return ["transactionId": transactionId]
        }
        return nil
    }
    
    var path: String {
        switch route {
        case .account:
            return String.getConfigurationValue(forKey: .acquiringMiddleAccountPath, from: .Core)
        case .refund:
            return String.getConfigurationValue(forKey: .acquiringMiddleRefundPath, from: .Core)
        }
    }
    
    var mapper: Mappeable {
        switch route {
        case .account:
            return AcquiringAccountMapper()
        case .refund:
            return AcquiringRefundMapper()
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var baseUrl: String {
        return String.getConfigurationValue(forKey: .acquiringMiddleURL, from: .Core)
    }
}
