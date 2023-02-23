//
//  UserAction.swift
//  UalaCore
//
//  Created by Ualá on 16/08/2022.
//

import Foundation

public struct UserAction: Codable {
    public var type: UserActionType
    public var message: String? = ""
    public var link: String? = ""
    public var buttons: [UserActionButton]
    
    public init(type: UserActionType, message: String? = "", link: String? = "", buttons: [UserActionButton]? = nil) {
        self.type = type
        self.message = message
        self.link = link
        self.buttons = buttons ?? []
    }
}

public struct UserActionButton: Codable {
    public let title: String?
    public let userAction: UserAction?
    
    public init(title: String?, userAction: UserAction?) {
        self.title = title
        self.userAction = userAction
    }
}

public enum UserActionType: String, Codable {
    case deepLink = "DEEP_LINK"
    case alert = "ALERT"
    case url = "URL"
    case custom = "CUSTOM"
    case unknown
    
    public init(safeRawValue: String) {
        let rawValue = safeRawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        self = UserActionType(rawValue: rawValue) ?? .unknown
    }
}
