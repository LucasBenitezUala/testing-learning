//
//  UserSessionActivityDataManager.swift
//  Uala
//
//  Created by Christian Correa on 27/05/21.
//  Copyright © 2021 Ualá. All rights reserved.
//

import Foundation
import PromiseKit

public final class UserSessionActivityDataManager: BaseRepository, UserSessionActivityDataManagerProtocol {
    
    public func requestUserProfile() -> Promise<UserSessionActivityResponseDTO> {
        return requestAuth0UserProfile(mapper: UserSessionActivityResponseDTO.self)
    }
}
