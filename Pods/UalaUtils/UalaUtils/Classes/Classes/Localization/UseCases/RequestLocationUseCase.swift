//
//  RequestLocationUseCase.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 21/10/21.
//

import Foundation
import Combine

public protocol RequestLocationUseCaseType {
    func execute() -> AnyPublisher<Void, Error>
}

public struct RequestLocationUseCase: RequestLocationUseCaseType {
    
    private let locationService: LocationServiceType
    private let getAuthorizationLocationStatusUsecase: GetAuthorizationLocationStatusUseCaseType
    
    public init(locationService: LocationServiceType,
                getAuthorizationLocationStatusUsecase: GetAuthorizationLocationStatusUseCaseType) {
        self.locationService = locationService
        self.getAuthorizationLocationStatusUsecase = getAuthorizationLocationStatusUsecase
    }
    
    public func execute() -> AnyPublisher<Void, Error> {
        
        return getAuthorizationLocationStatusUsecase.execute().flatMap { authStatus -> AnyPublisher<Void, Error> in
            if authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse {
                return locationService.requestLocation().eraseToAnyPublisher()
            } else {
                return Fail(error: LocationError.checkCLAAuthorization)
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}
