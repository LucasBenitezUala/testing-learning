//
//  TrackingRouter.swift
//  UalaCore
//
//  Created by Mario A. Barragan on 26/01/22.
//

import Alamofire

struct TrackingRouter: Routeable {
    
    var baseUrl: String {
        return String.getConfigurationValue(forKey: .trackingeBaseUrl, from: .Core)
    }
    
    var path: String {
        return "/api/v1/tracking"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var mapper: Mappeable {
        return TrackingMapper()
    }
}
