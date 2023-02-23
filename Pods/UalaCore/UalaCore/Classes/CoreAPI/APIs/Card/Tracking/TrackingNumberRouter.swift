//
//  TrackingNumberRouter.swift
//  UalaCore
//
//  Created by Mario A. Barragan on 16/05/22.
//

import Foundation
import Alamofire

struct TrackingNumberRouter: Routeable {
    
    var baseUrl: String {
        return String.getConfigurationValue(forKey: .baseUrlFreezeCol, from: .Core)
    }
    
    var path: String {
        return "/1/cards"
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
        return CardTrackingNumberMapper()
    }
}
