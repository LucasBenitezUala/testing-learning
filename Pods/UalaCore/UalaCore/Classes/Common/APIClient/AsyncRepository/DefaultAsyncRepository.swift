//
//  DefaultAsyncRepository.swift
//  UalaCore
//
//  Created by Luis Perez on 05/04/22.
//
import UalaNetwork

public final class DefaultAsyncRepository: AsyncRepository {
    private let apiClient: APIClient
    private let tokenProvider: AuthorizationTokenProvider?
    private let defaultErrorMapper: APIResponseErrorMapper
    
    public init(client: APIClient,
                tokenProvider: AuthorizationTokenProvider?,
                defaultErrorMapper: APIResponseErrorMapper) {
        
        self.apiClient = client
        self.tokenProvider = tokenProvider
        self.defaultErrorMapper = defaultErrorMapper
    }
    
    public convenience init(enableLogging: Bool = false) {
        
        self.init(client: AlamofireAPIClient(enableLogging: enableLogging),
                  tokenProvider: nil,
                  defaultErrorMapper: DefaultAPIClientErrorMapper())
    }
    
    public convenience init(enableLogging: Bool = false,
                     tokenProvider: AuthorizationTokenProvider) {
        
        self.init(client: AlamofireAPIClient(enableLogging: enableLogging),
                  tokenProvider: tokenProvider,
                  defaultErrorMapper: DefaultAPIClientErrorMapper())
    }
    
    public func request<Response: Decodable>(request: UalaCore.APIRequest,
                                  responseType: Response.Type,
                                  retries: Int = 0) async throws -> Response {
        
        return try await processRequestDependingOnType(request: request,
                                      responseType: responseType,
                                      retries: retries)
    }
    
    public func requestData(request: UalaCore.APIRequest,
                            retries: Int = 0) async throws -> Data {
        return try await processRequestDependingOnType(request: request,
                                                       responseType: Data.self,
                                                       retries: retries)
    }
    
    public func emptyResponseRequest(request: UalaCore.APIRequest, retries: Int) async throws {
        _ = try await processRequestDependingOnType(request: request,
                                                    responseType: Void.self,
                                                    retries: retries)
    }
    
    private func processRequestDependingOnType<Response>(request: UalaCore.APIRequest,
                                                       responseType: Response.Type,
                                                       retries: Int = 0) async throws -> Response {
        if request.authorizationType == .none {
            return try await processRequest(request: request,
                                            responseType: responseType,
                                            retries: retries)
        } else {
            return try await authorizedRequest(request: request,
                                               responseType: responseType,
                                               retries: retries)
        }
    }
    
    private func authorizedRequest<Response>(request: UalaCore.APIRequest,
                                            responseType: Response.Type,
                                            retries: Int = 0) async throws -> Response {
        
        guard let tokenProvider = tokenProvider else {
            throw APIClientError.missingAuthorizationToken
        }
        
        var mutableRequest = request
        let token = try await tokenProvider.authorizationToken()
        
        if mutableRequest.headers != nil {
            mutableRequest.headers?.merge(request.authorizationType.authorizationHeader(token: token),
                                   uniquingKeysWith: { current, _ in current })
        } else {
            mutableRequest.headers = request.authorizationType.authorizationHeader(token: token)
        }
        
        return try await processRequest(request: mutableRequest,
                                        responseType: responseType,
                                        retries: retries)
    }
    
    private func processRequest<Response>(request: UalaCore.APIRequest,
                                          responseType: Response.Type,
                                          retries: Int) async throws -> Response {
        
        if responseType is Data.Type {
            
            guard let response = try await processRequestData(request: request, retries: retries) as? Response else {
                throw UalaError.undefined
            }
            return response
        } else {
            return try await processRequestDecodable(request: request, responseType: responseType, retries: retries)
        }
    }
    
    private func processRequestDecodable<Response>(request: UalaCore.APIRequest,
                                          responseType: Response.Type,
                                          retries: Int) async throws -> Response {
        
        switch await apiClient.processRequest(request, retries: retries) {
        case .success(let responseData):
            return try request.responseDecoder.decode(type: responseType, from: responseData)
        case .failure(let error):
            throw defaultErrorMapper.mapError(error: error, requestErrorMapper: request.errorMapper)
        }
    }
    
    private func processRequestData(request: UalaCore.APIRequest, retries: Int) async throws -> Data {
        
        switch await apiClient.processRequest(request, retries: retries) {
        case .success(let responseData):
            return responseData
        case .failure(let error):
            throw defaultErrorMapper.mapError(error: error, requestErrorMapper: request.errorMapper)
        }
    }
}
