//
//  UserManagementRepository.swift
//  UalaCore
//
//  Created by Ualá on 04/08/21.
//

import Foundation
import PromiseKit

public protocol UserManagementRepositoryProtocol {
    func addBeneficiary(beneficiaryBirth: String,
                        beneficiaryEmail: String,
                        beneficiaryLastName: String,
                        beneficiaryName: String,
                        percentage: Int,
                        mfaPin: String,
                        mfaPinId: String) -> Promise<Void>
    func getBeneficiariesList() -> Promise<BeneficiariesList>
    func deleteBeneficiary(
        beneficiaryId: String,
        mfaPin: String,
        mfaPinId: String
    ) -> Promise<Void>
}

public final class UserManagementRepository: BaseRepository, UserManagementRepositoryProtocol {
    
    private var serviceApi = UserManagementAPI(UserManagementManager())
    
    public func addBeneficiary(beneficiaryBirth: String,
                               beneficiaryEmail: String,
                               beneficiaryLastName: String,
                               beneficiaryName: String,
                               percentage: Int,
                               mfaPin: String,
                               mfaPinId: String) -> Promise<Void> {
        requestAuth(serviceApi.userManagementAPI(
                        route: .addBeneficiary(beneficiaryBirth,
                                               beneficiaryEmail,
                                               beneficiaryLastName,
                                               beneficiaryName,
                                               percentage,
                                               mfaPin,
                                               mfaPinId)))
    }
    
    public func getBeneficiariesList() -> Promise<BeneficiariesList> {
        requestAuth(serviceApi.userManagementAPI(route: .getBeneficiariesList))
    }
    
    public func deleteBeneficiary(
        beneficiaryId: String,
        mfaPin: String,
        mfaPinId: String
    ) -> Promise<Void> {
        requestAuth(serviceApi.userManagementAPI(route: .deleteBeneficiary(beneficiaryId, mfaPin, mfaPinId)))
    }
}
