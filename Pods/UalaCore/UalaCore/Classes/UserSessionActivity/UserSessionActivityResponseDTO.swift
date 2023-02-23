//
//  UserSessionActivityResponseDTO.swift
//  UalaHome
//
//  Created by Aldo Martinez on 07/06/22.
//

import Foundation

public struct UserSessionActivityResponseDTO: Codable {
    public var geoip: UserSessionActivityGeoIp
    public var lastLoginDate: Int64

    enum CodingKeys: String, CodingKey {
        case geoip = "https://example.com/lastGeoip"
        case lastLoginDate = "https://example.com/lastLogin"
    }
}

public struct UserSessionActivityGeoIp: Codable {
    public var countryCode: String
    public var countryName: String
    public var cityName: String

    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code",
             countryName = "country_name",
             cityName = "city_name"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode) ?? ""
        self.countryName = try container.decode(String.self, forKey: .countryName)
        self.cityName = try container.decodeIfPresent(String.self, forKey: .cityName) ?? ""
    }
}
