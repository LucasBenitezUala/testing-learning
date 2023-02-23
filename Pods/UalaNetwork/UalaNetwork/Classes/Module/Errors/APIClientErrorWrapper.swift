//
//  APIClientErrorWrapper.swift
//  UalaNetwork
//
//  Created by Luis Perez on 29/03/22.
//

public struct APIClientErrorWrapper: Error {
    
    public let error: Error
    public let responseData: Data?
    
    public init(error: Error, responseData: Data?) {
        self.error = error
        self.responseData = responseData
    }
}
