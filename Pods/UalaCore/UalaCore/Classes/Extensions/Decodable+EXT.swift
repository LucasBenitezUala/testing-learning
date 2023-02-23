//
//  Decodable+EXT.swift
//  UalaCore
//
//  Created by Luis Perez on 07/04/22.
//

import Foundation

// This Extension is needed because the generic decoder can't infer the type.
extension Decodable {
    init(data: Data, decoder: JSONDecoder) throws {
        self = try decoder.decode(Self.self, from: data)
    }
}
