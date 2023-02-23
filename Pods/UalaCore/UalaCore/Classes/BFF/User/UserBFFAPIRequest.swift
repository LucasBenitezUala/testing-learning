//
//  UserBFFAPIRequest.swift
//  UalaCore
//
//  Created by Matías Schwalb on 01/06/2022.
//

public struct UserBFFAPIRequest: APIRequest {
    
    public init() {}
    
    public var url: String {
        return String.getConfigurationValue(forKey: ConfigurationKey.bffUserBaseUrl, from: .Core) + "api/v1/user"
    }

    public var responseDecoder: APIResponseDecoder {
        return VoidableAPIResponseDecoder()
    }
    
    public var authorizationType: APIClientAuthorizationType {
        return .bearerToken
    }
    
    public var headers: [String: String]?
    
    public var method: HTTPRequestMethod {
        return .get
    }
    
    public var parameters: [String: Any]?
    
    public var encoding: HTTPParameterEncoding {
        return .JSONEncoding(type: .default)
    }
    
    public var errorMapper: Mappeable?
}
