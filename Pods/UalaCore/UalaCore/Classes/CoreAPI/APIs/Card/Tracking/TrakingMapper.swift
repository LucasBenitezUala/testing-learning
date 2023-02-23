//
//  TrakingMapper.swift
//  UalaCore
//
//  Created by Mario A. Barragan on 26/01/22.
//

import Foundation
import UalaCore

struct TrackingMapper: MappeableType {
    typealias Result = Data
    
    func map<T>(_ data: Data) -> T? {
        return data as? T
    }
}
