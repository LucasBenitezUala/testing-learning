//
//  Province.swift
//  Uala
//
//  Created by Nelson Domínguez on 01/08/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public class Province: CustomStringConvertible, Equatable, Decodable {
    
    public let code: String
    public let name: String
    
    private enum CodingKeys: String, CodingKey {
        case code = "id"
        case name = "nombre"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let intCode = try container.decode(Int.self, forKey: .code)
        name = try container.decode(String.self, forKey: .name)
        code = String(intCode)
    }
    
    public init(code: String, name: String) {
        self.code = code
        self.name = name
    }
    
    public var description: String {
        return name
    }
    
    public static func==(lhs: Province, rhs: Province) -> Bool {
        return lhs.code == rhs.code
    }
}

public extension Province {
    static func fromLocalBundle() -> [Province] {
        let bundle = BundleUtils.getBundle(from: .Core)
        guard let path = bundle.path(forResource: "provinces", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped),
              let result = try? JSONDecoder().decode([Province].self, from: data) else { return [] }
        return result
    }
}
