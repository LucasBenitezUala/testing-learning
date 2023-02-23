//
//  APIResponseErrorMapper.swift
//  UalaCore
//
//  Created by Luis Perez on 05/04/22.
//
import UalaNetwork

public protocol APIResponseErrorMapper {
    func mapError(error: APIClientErrorWrapper, requestErrorMapper: Mappeable?) -> Error
}
