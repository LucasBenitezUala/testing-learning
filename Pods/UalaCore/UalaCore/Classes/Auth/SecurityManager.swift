//
//  SecurityManager.swift
//
//  Created by Agustin Jaimes on 01/11/21.
//

import Foundation

public class SecurityManager {

    public static let shared = SecurityManager()
    private var token: String?
    private var accountId: String?

    private init() {
        // Default init: Will move to Auth Repository when ready.
    }

    public func setAuthToken(_ token: String) {
        self.token = token
    }

    public func getAuthToken() -> String? {
        return token
    }
    
    public func setAccountId(_ accountId: String) {
        self.accountId = accountId
    }

    public func getAccountId() -> String? {
        return accountId
    }

    public func reset() {
        token = ""
        accountId = ""
    }
}
