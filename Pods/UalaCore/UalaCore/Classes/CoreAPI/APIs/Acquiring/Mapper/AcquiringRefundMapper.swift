//
//  AcquiringRefundMapper.swift
//  UalaCore
//
//  Created by Matias Palmieri on 14/02/2022.
//

import Foundation

struct AcquiringRefundMapper: MappeableType {
    
    typealias Result = AcquiringRefundDTO
    
    func map<T>(_ data: Data) -> T? {
        return decode(data) as? T
    }
}
