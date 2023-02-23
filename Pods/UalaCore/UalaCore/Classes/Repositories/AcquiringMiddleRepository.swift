//
//  AccountMiddleRepository.swift
//  UalaCore
//
//  Created by Diego Palomares on 09/11/21.
//

import Foundation
import PromiseKit

public protocol AcquiringMiddleRepositoryProtocol {
    func currentMiddleAccount() -> Promise<AcquiringAccountDTO>
    func currentRefundTransaction(transactionId: String) -> Promise<AcquiringRefundDTO>
}

public class AcquiringMiddleRepository: BaseRepository, AcquiringMiddleRepositoryProtocol {
    public func currentMiddleAccount() -> Promise<AcquiringAccountDTO> {
        return requestAuth(coreAPI.acquiringAccount(route: .account))
    }
    
    public func currentRefundTransaction(transactionId: String) -> Promise<AcquiringRefundDTO> {
        return requestAuth(coreAPI.acquiringAccount(route: .refund(transactionId: transactionId)))
    }
}
