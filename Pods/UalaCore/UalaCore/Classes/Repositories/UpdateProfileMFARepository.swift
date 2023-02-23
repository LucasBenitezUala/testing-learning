//
//  UpdateProfileMFARepository.swift
//  UalaCore
//
//  Created by Ualá on 22/06/21.
//

import Foundation
import PromiseKit

public protocol UpdateProfileMFARepositoryProtocol {
    func sendProfileMFA() -> Promise<UpdateProfileSendMFA>
    func resendProfileMFA(pinId: String) -> Promise<UpdateProfileSendMFA>
}

public final class UpdateProfileMFARepository: BaseRepository, UpdateProfileMFARepositoryProtocol {
    
    private var serviceApi = UpdateProfileMFAAPI(UpdateProfileMFAManager())
    
    public func sendProfileMFA() -> Promise<UpdateProfileSendMFA> {
        return requestAuth(serviceApi.userManagementAPI(route: .send))
    }
    
    public func resendProfileMFA(pinId: String) -> Promise<UpdateProfileSendMFA> {
        return requestAuth(serviceApi.userManagementAPI(route: .resend(pinId)))
    }
}
