//
//  PromiseKit+Extensions.swift
//  UalaUtils
//
//  Created by Alan Valencia on 07/03/22.
//

import PromiseKit
import Combine

public extension Promise {
    
    public func asPublisher() -> AnyPublisher<T, Error> {
        return Future<T, Error> { [weak self] promise in
            self?.done { body in
                promise(.success(body))
            }.catch { error in
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
