//
//  GetErrorLocationUseCase.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 21/10/21.
//

import Foundation
import Combine

public protocol GetErrorLocationUseCaseType {
    func execute() -> AnyPublisher<Error, Never>
}

public struct GetErrorLocationUseCase: GetErrorLocationUseCaseType {
    
    private let locationService: LocationServiceType
    
    public init(locationService: LocationServiceType) {
        self.locationService = locationService
    }
    
    public func execute() -> AnyPublisher<Error, Never> {
        return locationService.getErrorLocation()
    }
}
