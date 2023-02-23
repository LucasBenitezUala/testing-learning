//
//  SplitFeature.swift
//  UalaCore
//
//  Created by Luis Perez on 08/09/21.
//

public struct SplitFeature: SplitFeatureType, Hashable {
    public var id: String
    
    public init(id: String) {
        self.id = id
    }
}
