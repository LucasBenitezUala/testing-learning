//
//  UserCatalogBFFAPIRequest.swift
//  UalaCore
//
//  Created by Matías Schwalb on 07/06/2022.
//

public struct UserCatalogBFFAPIRequest: APIRequest {
    
    public init(catalog: UserCatalogType) {
        self.catalog = catalog
    }
    
    private let catalog: UserCatalogType
    
    public var url: String {
        return String.getConfigurationValue(forKey: ConfigurationKey.bffUserBaseUrl, from: .Core) + "api/v1/catalog/\(catalog.rawValue)"
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

public enum UserCatalogType: String {
    case specialCondition = "SpecialCondition"
    case belongsToCollective = "BelongsToCollective"
}
