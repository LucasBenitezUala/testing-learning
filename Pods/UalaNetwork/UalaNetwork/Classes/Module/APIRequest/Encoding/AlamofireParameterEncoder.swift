//
//  AlamofireParameterEncoder.swift
//  UalaNetwork
//
//  Created by Luis Perez on 04/04/22.
//

import Alamofire

protocol AlamofireParameterEncoder {
    func encodingType() -> ParameterEncoding
}

extension HTTPParameterEncoding: AlamofireParameterEncoder {
    
    func encodingType() -> ParameterEncoding {
        switch self {
        case .JSONEncoding(type: let type):
            switch type {
            case .default:
                return Alamofire.JSONEncoding.default
            case .prettyPrinted:
                return Alamofire.JSONEncoding.prettyPrinted
            }
            
        case .URLEncoding(type: let type):
            switch type {
            case .default:
                return Alamofire.URLEncoding.default
            case .httpBody:
                return Alamofire.URLEncoding.httpBody
            case .queryString:
                return Alamofire.URLEncoding.queryString
            }
        }
    }
}
