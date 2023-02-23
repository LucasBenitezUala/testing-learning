//
//  EmailSendResponse.swift
//  Alamofire
//
//  Created by Agustin Jaimes on 26/04/22.
//

import Foundation

public struct EmailSendResponse: Decodable {
    public let pinId: String
    
    enum CodingKeys: String, CodingKey {
        case pinId = "pinId"
    }
}

struct EmailSendMapper: MappeableType {

    typealias Result = EmailSendResponse

    func map<T>(_ data: Data) -> T? {
        return decode(data) as? T
    }
}
