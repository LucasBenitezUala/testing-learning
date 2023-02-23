//
//  AcquiringAccountRoutable.swift
//  UalaCore
//
//  Created by Diego Palomares on 08/11/21.
//

import Foundation

public enum AcquiringAccountRoute {
    case account
    case refund(transactionId: String)
}

public protocol AcquiringAccountRoutable: Routeable {
    var route: AcquiringAccountRoute { get set }
}
