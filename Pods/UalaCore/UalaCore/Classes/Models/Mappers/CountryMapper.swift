//
//  CountryMapper.swift
//  Uala
//
//  Created by Nelson Domínguez on 25/08/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

class CountryMapper {
    
    static func map(from dto: RemoteCountry) -> Country {
        let code = dto.ccn3
        let name = name(code: dto.cca2)
        let flag = flag(code: dto.cca2)
        
        return Country(code: code, name: name, flag: flag)
    }
    
    private static func flag(code: String) -> String {
        let base: UInt32 = 127397
        // swiftlint:disable:next force_unwrapping
        return code.unicodeScalars.compactMap { String.init(UnicodeScalar(base + $0.value)!) }.joined()
    }
    
    private static func name(code: String) -> String {
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        return NSLocale(localeIdentifier: NSLocale.current.identifier).displayName(forKey: NSLocale.Key.identifier, value: id) ?? code
    }
}
