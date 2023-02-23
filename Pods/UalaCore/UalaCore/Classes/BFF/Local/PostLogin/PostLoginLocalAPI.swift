//
//  PostLoginLocalAPI.swift
//  Uala
//
//  Created by Andrés Abraham Bonilla Gómex on 17/02/22.
//  Copyright © 2022 Ualá. All rights reserved.
//

import Foundation
import Combine
import UalaUtils

public class PostLoginLocalAPI: PostLoginLocalDataSourceType {
    
    public static let shared = PostLoginLocalAPI()
    private var account: Account?
    
    public func save(_ account: Account?) -> AnyPublisher<Void, Error> {
        self.account = account
        return Just(()).genericError().eraseToAnyPublisher()
    }
    
    public func getInfo() -> AnyPublisher<Account?, Error> {
        guard let account = account else {
            return Just(nil).genericError().eraseToAnyPublisher()
        }

        return Just(account).genericError().eraseToAnyPublisher()
    }
}
