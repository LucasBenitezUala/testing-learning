//
//  HTTPParameterEncoding.swift
//  UalaNetwork
//
//  Created by Luis Perez on 04/04/22.
//
import Alamofire

public enum HTTPParameterEncoding: Equatable {
    case JSONEncoding(type: JsonEncodingType = .default)
    case URLEncoding(type: URLEncodingType = .default)
}

public enum JsonEncodingType: Equatable {
    case prettyPrinted
    case `default`
}

public enum URLEncodingType: Equatable {
    case `default`
    case queryString
    case httpBody
}
