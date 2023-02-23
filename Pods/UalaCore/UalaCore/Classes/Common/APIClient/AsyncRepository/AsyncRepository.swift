//
//  AsyncRepository.swift
//  UalaCore
//
//  Created by Luis Perez on 05/04/22.
//

public protocol AsyncRepository: AnyObject {
    
    func request<Response: Decodable>(request: APIRequest,
                                      responseType: Response.Type,
                                      retries: Int) async throws -> Response
    
    func requestData(request: APIRequest, retries: Int) async throws -> Data
    
    func emptyResponseRequest(request: APIRequest,
                              retries: Int) async throws
}
