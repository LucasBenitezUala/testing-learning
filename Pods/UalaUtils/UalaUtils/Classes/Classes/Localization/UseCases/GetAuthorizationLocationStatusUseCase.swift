//
//  GetAuthorizationLocationStatusUseCase.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 21/10/21.
//

import Foundation
import Combine
import CoreLocation

public protocol GetAuthorizationLocationStatusUseCaseType {
    func execute() -> AnyPublisher<CLAuthorizationStatus, Error>
}

public struct GetAuthorizationLocationStatusUseCase: GetAuthorizationLocationStatusUseCaseType {
    
    private let locationService: LocationServiceType
    
    public init(locationService: LocationServiceType) {
        self.locationService = locationService
    }
    
    public func execute() -> AnyPublisher<CLAuthorizationStatus, Error> {
        return locationService.authorizationStatus()
    }
}

public struct GetLocationDelegateUseCase: GetAuthorizationLocationStatusUseCaseType {
    
    private let locationService: LocationServiceType
    
    public init(locationService: LocationServiceType) {
        self.locationService = locationService
    }
    
    public func execute() -> AnyPublisher<CLAuthorizationStatus, Error> {
        return locationService.currentAuthStatus.genericError().eraseToAnyPublisher()
    }
}
