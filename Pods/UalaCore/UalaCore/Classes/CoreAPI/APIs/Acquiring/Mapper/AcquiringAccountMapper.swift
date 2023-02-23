//
//  AcquiringAccountMapper.swift
//  UalaCore
//
//  Created by Diego Palomares on 08/11/21.
//

import Foundation

struct AcquiringAccountMapper: MappeableType {
    
    typealias Result = AcquiringAccountDTO
    
    func map<T>(_ data: Data) -> T? {
        return decode(data) as? T
    }
}
