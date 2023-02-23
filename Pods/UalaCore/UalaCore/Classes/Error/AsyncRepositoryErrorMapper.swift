//
//  AsyncRepositoryErrorMapper.swift
//  UalaCore
//
//  Created by Luis Perez on 30/03/22.
//
import UalaNetwork

public struct DefaultAPIClientErrorMapper: APIResponseErrorMapper {
    
    public init() {
        // Empty init because we have no properties.
    }
    
    public func mapError(error: APIClientErrorWrapper, requestErrorMapper: Mappeable?) -> Error {
        
        guard let errorMapper = requestErrorMapper,
              let responseData = error.responseData else {
            return error.error
        }

        if let ualaError: UalaError = errorMapper.map(responseData) {
            return ualaError
        } else if let beError: BEError = errorMapper.map(responseData) {
            return beError
        } else if let error: Error = errorMapper.map(responseData) {
            return error
        } else {
            return error.error
        }
    }
}
