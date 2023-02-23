//
//  AlamofireAPIClient.swift
//  UalaNetwork
//
//  Created by Luis Perez on 29/03/22.
//

import Alamofire

public final class AlamofireAPIClient: APIClient {
    
    private let session: Session

    public init(eventMonitors: [EventMonitor]) {
        self.session = Session(eventMonitors: eventMonitors)
    }

    public convenience init(enableLogging: Bool = false) {
        if enableLogging {
            self.init(eventMonitors: [AlamofireEventLogger()])
        } else {
            self.init(eventMonitors: [])
        }
    }
    
    public func processRequest(_ request: APIRequest, retries: Int = 0) async -> Result<Data, APIClientErrorWrapper> {
        for _ in 0..<retries {
            switch await processRequest(request: request) {
            case .success(let data):
                return .success(data)
            case .failure(let error):
                continue
            }
        }
        
        return try await processRequest(request: request)
    }
    
    private func processRequest(request: APIRequest) async -> Result<Data, APIClientErrorWrapper> {
        return try await withCheckedContinuation({ continuation in
            session.request(request.url,
                            method: Alamofire.HTTPMethod(rawValue: request.method.rawValue),
                            parameters: request.parameters,
                            encoding: request.encoding.encodingType(),
                            headers: HTTPHeaders(request.headers ?? [:]))
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: .success(data))
                    case .failure(let error):
                        continuation.resume(returning: .failure(APIClientErrorWrapper(error: error, responseData: response.data)))
                    }
                }
        })
    }
}
