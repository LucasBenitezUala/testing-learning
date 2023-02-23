//
//  PostLoginAPIRequest.swift
//  Uala
//
//  Created by Luis Perez on 08/04/22.
//  Copyright © 2022 Ualá. All rights reserved.
//

struct PostLoginAPIRequest: APIRequest {
    
    private let model: PostLoginRequestModel
    
    init(model: PostLoginRequestModel = PostLoginRequestModel()) {
        self.model = model
    }
    
    var url: String {
        return .getConfigurationValue(forKey: ConfigurationKey.bffPostlogin, from: .Core) + "/v1/init"
    }
    
    var method: HTTPRequestMethod {
        return .post
    }
    
    var encoding: HTTPParameterEncoding {
        return .JSONEncoding(type: .default)
    }
    
    var authorizationType: APIClientAuthorizationType {
        return .bearerToken
    }
    
    var responseDecoder: APIResponseDecoder {
        return VoidableAPIResponseDecoder()
    }
    
    var errorMapper: Mappeable?
    
    var headers: [String: String]?
    
    var parameters: [String: Any]? {
        let param: [String: Any] = ["userSession": [
            "advertisingPlatform": model.advertisingPlatform,
            "pushPlatform": model.pushPlatform,
            "pushToken": model.pushToken,
            "deviceId": model.deviceId
        ]]
        return param
    }
}
