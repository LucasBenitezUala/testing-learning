//
//  Publisher+Extensions.swift
//  Utils
//
//  Created by Andrés Bonilla Gómez on 21/10/21.
//

import Foundation
import Combine

public extension Publisher {
    
    func genericError() -> AnyPublisher<Self.Output, Error> {
        return self
            .mapError({ (error: Self.Failure) -> Error in
                return error
            }).eraseToAnyPublisher()
    }
}
