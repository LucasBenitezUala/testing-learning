//
//  GetCurrentLocationUseCase.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 21/10/21.
//

import Foundation
import Combine
import CoreLocation

public protocol GetCurrentLocationUseCaseType {
    func execute() -> AnyPublisher<CLLocation, Error>
}

public struct GetCurrentLocationUseCase: GetCurrentLocationUseCaseType {
    
    private let locationService: LocationServiceType
    private let getAuthorizationLocationStatusUsecase: GetAuthorizationLocationStatusUseCaseType
    
    public init(locationService: LocationServiceType,
                getAuthorizationLocationStatusUsecase: GetAuthorizationLocationStatusUseCaseType) {
        self.locationService = locationService
        self.getAuthorizationLocationStatusUsecase = getAuthorizationLocationStatusUsecase
    }
    
    public func execute() -> AnyPublisher<CLLocation, Error> {
        return getAuthorizationLocationStatusUsecase.execute().flatMap { authStatus -> AnyPublisher<CLLocation, Error> in
            if authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse {
                return locationService.currentLocation.eraseToAnyPublisher()
            } else {
                return Fail(error: LocationError.checkCLAAuthorization)
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}
