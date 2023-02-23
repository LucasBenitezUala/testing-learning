//
//  VoidableAPIResponseDecoder.swift
//  UalaCore
//
//  Created by Luis Perez on 07/04/22.
//

public final class VoidableAPIResponseDecoder: APIResponseDecoder {
    private let decoder: JSONDecoder

    public init(decoder: JSONDecoder) {
        self.decoder = decoder
    }

    public convenience init() {
        self.init(decoder: JSONDecoder())
    }

    public func decode<T>(type: T.Type, from data: Data) throws -> T {
        if type.self == Void.self, let result = () as? T {
            return result
        } else if let decodableType = type as? Decodable.Type,
                  let decodedObject = try decodableType.init(data: data, decoder: decoder) as? T {
            return decodedObject
        }
        
        throw UalaError.undefined
    }
}
