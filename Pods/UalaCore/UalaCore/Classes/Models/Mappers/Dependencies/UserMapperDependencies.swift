//
//  UserMapperDependencies.swift
//  Alamofire
//
//  Created by Enzo Digiano on 27/10/2020.
//

import Foundation
import UalaUtils

protocol UserMapperDependenciesProtocol {
    func map(from dto: RemoteUser.User) -> User
}

extension Argentina: UserMapperDependenciesProtocol {
    func map(from dto: RemoteUser.User) -> User {
        let user = User(email: dto.email)
        GenericUserMapper.mapCommonUser(user, from: dto)
        user.document = dto.documentId?.notNullString()
        return user
    }
}

extension Mexico: UserMapperDependenciesProtocol {
    func map(from dto: RemoteUser.User) -> User {
        let user = MexUser(email: dto.email)
        GenericUserMapper.mapUser(user, from: dto)
        user.documentId = dto.CURP
        user.document = dto.CURP?.notNullString()
        return user
    }
}

extension MexicoABC: UserMapperDependenciesProtocol {
    func map(from dto: RemoteUser.User) -> User {
        let user = MexUser(email: dto.email)
        GenericUserMapper.mapUser(user, from: dto)
        user.documentId = dto.CURP
        user.document = dto.CURP?.notNullString()
        return user
    }
}

extension Colombia: UserMapperDependenciesProtocol {
    func map(from dto: RemoteUser.User) -> User {
        let user = ColUser(email: dto.email)
        GenericUserMapper.mapUser(user, from: dto)
        
        user.documentId = dto.documentId?.notNullString()
        user.document = dto.documentType?.notNullString()

        return user
    }
}

extension ArgentinaBank: UserMapperDependenciesProtocol {
    
    func map(from dto: RemoteUser.User) -> User {
        let user = ColUser(email: dto.email)
        GenericUserMapper.mapUser(user, from: dto)
        
        user.documentId = dto.documentId?.notNullString()
        user.document = dto.documentType?.notNullString()
        
        return user
    }
}

extension String {
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.symbols).joined(separator: "")
    }
    
    /// Conver a `json` to a dictionary of `[String: Any]`
    func convertToDictinary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                LogManager.shared.debugError(error: error, type: "Error converting to [String: Any]")
            }
        }
        return nil
    }
}

extension Dictionary {
    /// This extension let you cast the element of a `Dictionary` by defining its `type`
    /// Example:  `let code: String? = someDictionary.parse("someKey")`
    func parse<T>(_ key: Key) -> T? {

        let result = self[key]

        if result is T {
            return result as? T
        }

        return nil
    }
}
