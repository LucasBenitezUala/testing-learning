//
//  APIRequest.swift
//  UalaNetwork
//
//  Created by Luis Perez on 29/03/22.
//

public protocol APIRequest {
    var url: String { get }
    var method: HTTPRequestMethod { get }
    var parameters: [String: Any]? { get }
    var encoding: HTTPParameterEncoding { get }
    var headers: [String: String]? { get }
}
