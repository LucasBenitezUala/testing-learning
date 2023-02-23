//
//  APIRequest+EXT.swift
//  UalaCore
//
//  Created by Luis Perez on 04/04/22.
//

import UalaNetwork

public protocol APIRequest: UalaNetwork.APIRequest {
    var errorMapper: Mappeable? { get }
    var responseDecoder: APIResponseDecoder { get }
    var authorizationType: APIClientAuthorizationType { get }
    var headers: [String: String]? { get set }
}
