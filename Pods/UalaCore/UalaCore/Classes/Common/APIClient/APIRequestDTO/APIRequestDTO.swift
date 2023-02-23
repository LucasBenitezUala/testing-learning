//
//  APIRequestDTO.swift
//  UalaCore
//
//  Created by Luis Perez on 05/04/22.
//
import UalaNetwork
import Alamofire

public struct APIRequestDTO: UalaCore.APIRequest {
    public var errorMapper: Mappeable?
    public var responseDecoder: APIResponseDecoder
    public var url: String
    public var method: HTTPRequestMethod
    public var parameters: [String: Any]?
    public var encoding: HTTPParameterEncoding
    public var headers: [String: String]?
    public var authorizationType: APIClientAuthorizationType
    
    public init(routeable: Routeable, authorizationType: APIClientAuthorizationType = .none) {
        self.errorMapper = routeable.errorMapper
        self.responseDecoder = VoidableAPIResponseDecoder()
        self.url = routeable.baseUrl + routeable.path
        self.method = HTTPRequestMethod(rawValue: routeable.method.rawValue) ?? .post
        self.parameters = routeable.parameters
        self.encoding = APIRequestDTO.convertAlamofireEncoding(alamofireEncoding: routeable.encoding)
        self.headers = routeable.headers?.dictionary
        self.authorizationType = authorizationType
    }
    
    private static func convertAlamofireEncoding(alamofireEncoding: ParameterEncoding) -> HTTPParameterEncoding {
        
        if let encoding = alamofireEncoding as? JSONEncoding {
            if encoding.options == .prettyPrinted {
                return .JSONEncoding(type: .prettyPrinted)
            } else {
                return .JSONEncoding(type: .default)
            }
        } else if let encoding = alamofireEncoding as? URLEncoding {
            if encoding.destination == .queryString {
                return .URLEncoding(type: .queryString)
            } else if encoding.destination == .httpBody {
                return .URLEncoding(type: .httpBody)
            } else {
                return .URLEncoding(type: .default)
            }
        } else {
            return .JSONEncoding(type: .default)
        }
    }
}
