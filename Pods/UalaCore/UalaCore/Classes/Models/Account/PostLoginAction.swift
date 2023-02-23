//
//  PostLoginAction.swift
//  UalaCore
//
//  Created by Andrés Abraham Bonilla Gómex on 23/02/22.
//

import Foundation

public struct PostLoginAction {

    public let type: PostLoginActionType
    public let path: PostLoginPathType
    public let pendingAction: PostLoginPendingActionType
    public let title: String
    public let message: String
    
    public init(type: PostLoginActionType = .unknown,
                path: PostLoginPathType = .unknown,
                pendingAction: PostLoginPendingActionType = .unknown,
                title: String = "",
                message: String = "") {
        self.type = type
        self.path = path
        self.pendingAction = pendingAction
        self.title = title
        self.message = message
    }
}

public enum PostLoginActionType: String {
    
    case deepLink = "DEEP_LINK"
    case alert = "ALERT"
    case unknown
}

public enum PostLoginPathType: String {
    
    case home = "home"
    case onboarding = "on_boarding"
    case pendingUserAction = "pending_user_action"
    case pendingMinorAction = "pending_minor_action"
    case pendingValidation = "pending_validation"
    case invalidAccount = "invalid_account"
    case unknown = ""
    
    static public func getPath(url: String) -> PostLoginPathType {
        let urlSplit: [String] = url.components(separatedBy: "com/")
        guard let urlPath: String = urlSplit.last else {
            return .unknown
        }
        
        let path: [String] = urlPath.components(separatedBy: "?")
        guard let pathType: String = path.first else {
            return .unknown
        }
        
        let postLoginPath: PostLoginPathType = PostLoginPathType(rawValue: pathType) ?? .unknown
        return postLoginPath
    }
}

public enum PostLoginPendingActionType: String {
    
    case idFront = "ID_FRONT"
    case idBack = "ID_BACK"
    case idPhotos = "ID_PHOTOS"
    case selfie = "SELFIE"
    case idSelfie = "ID_SELFIE"
    case idExpired = "ID_EXPIRED"
    case `default` = "DEFAULT"
    case unknown = ""
    
    static public func getPendingAction(url: String) -> PostLoginPendingActionType {
        guard let url = URLComponents(string: url),
              let userActionType = url.queryItems?.first(where: { $0.name == "userActionType" })?.value else {
            return .unknown
        }
        
        return PostLoginPendingActionType(rawValue: userActionType) ?? .unknown
    }
}
