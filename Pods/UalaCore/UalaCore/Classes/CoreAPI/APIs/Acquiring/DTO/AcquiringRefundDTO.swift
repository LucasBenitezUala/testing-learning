//
//  AcquiringRefundDTO.swift
//  UalaCore
//
//  Created by Matias Palmieri on 14/02/2022.
//

import Foundation

public struct AcquiringRefundDTO: Decodable {
    
    public let isRefund: Bool
    public let refundUrl: String
    public let refundCause: RefundCause
}

public enum RefundCause: String, Decodable {
    case insufficientBalance = "201"
    case limitDateRefund = "202"
    case typeOfSellNotSupport = "203"
    case unknown = ""
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        self = RefundCause(rawValue: string) ?? .unknown
    }
}
