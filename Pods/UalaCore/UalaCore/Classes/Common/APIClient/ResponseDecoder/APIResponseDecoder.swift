//
//  APIResponseDecoder.swift
//  UalaCore
//
//  Created by Luis Perez on 07/04/22.
//

public protocol APIResponseDecoder {
    func decode<T>(type: T.Type, from data: Data) throws -> T
}
