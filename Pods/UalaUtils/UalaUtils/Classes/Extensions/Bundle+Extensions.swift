//
//  Bundle+Extensions.swift
//  UalaUtils
//
//  Created by Monserrath Castro on 16/08/22.
//

import Foundation

extension Bundle {
    public func getFromLocalJson<T: Codable>(fileName: String) -> T? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return nil }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            return try? JSONDecoder().decode(T.self, from: data)
        } catch _ {
            return nil
        }
    }
}
