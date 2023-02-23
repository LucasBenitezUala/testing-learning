//
//  StarLocalization.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 21/10/21.
//

import Foundation
import Combine

public protocol StarLocalizationUseCaseType {
    func execute(type: RequestTypeLocation) -> AnyPublisher<Void, Error>
}

public struct StarLocalizationUseCase: StarLocalizationUseCaseType {
    
    private let locationService: LocationServiceType
    private let getAuthorizationLocationStatusUsecase: GetAuthorizationLocationStatusUseCaseType
    private let requestLocationUseCase: RequestLocationUseCaseType
    
    public init(locationService: LocationServiceType,
                getAuthorizationLocationStatusUsecase: GetAuthorizationLocationStatusUseCaseType,
                requestLocationUseCase: RequestLocationUseCaseType) {
        self.locationService = locationService
        self.getAuthorizationLocationStatusUsecase = getAuthorizationLocationStatusUsecase
        self.requestLocationUseCase = requestLocationUseCase
    }
    
    public func execute(type: RequestTypeLocation) -> AnyPublisher<Void, Error> {
        
        return getAuthorizationLocationStatusUsecase.execute()
            .flatMap { authStatus -> AnyPublisher<Void, Error> in
                if authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse {
                    return requestLocationUseCase.execute()
                } else if authStatus == .notDetermined {
                    return askLocationProccess(type: type)
                } else {
                    return Fail(error: LocationError.checkCLAAuthorization)
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    private func askLocationProccess(type: RequestTypeLocation) -> AnyPublisher<Void, Error> {
        return locationService.askLocationPermits(type: type)
            .flatMap { () -> AnyPublisher<Void, Error> in
                return getAuthorizationLocationStatusUsecase.execute()
                    .flatMap { authStatus -> AnyPublisher<Void, Error> in
                        if authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse {
                            return requestLocationUseCase.execute()
                        } else {
                            return Fail(error: LocationError.checkCLAAuthorization)
                                .eraseToAnyPublisher()
                        }
                    }.eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
}
