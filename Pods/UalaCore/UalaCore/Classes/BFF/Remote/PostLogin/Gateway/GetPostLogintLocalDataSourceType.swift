//
//  GetPostLogintLocalDataSourceType.swift
//  Uala
//
//  Created by Andrés Abraham Bonilla Gómex on 17/02/22.
//  Copyright © 2022 Ualá. All rights reserved.
//

import Foundation
import Combine

public protocol PostLoginLocalDataSourceType {
    func save(_ account: Account?) -> AnyPublisher<Void, Error>
    func getInfo() -> AnyPublisher<Account?, Error>
}
