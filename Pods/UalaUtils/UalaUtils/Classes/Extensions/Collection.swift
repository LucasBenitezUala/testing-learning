//
//  Collection.swift
//  UalaUtils
//
//  Created by Matias LaDelfa on 12/10/2021.
//

import Foundation

/// Adds [safe: ] as alternative access to arrays in order to avoid crashes due 'out of bounds' index.
extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}
