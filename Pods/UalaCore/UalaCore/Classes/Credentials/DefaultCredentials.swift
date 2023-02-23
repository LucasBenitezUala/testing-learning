//
//  DefaultCredentials.swift
//  UalaCore
//
//  Created by Andrés Abraham Bonilla Gómex on 21/10/21.
//

import Foundation
import PromiseKit

struct DefaultCredentials: Credentials {
    
    var isUserSignedIn: Bool = false
    
    func getToken() -> Promise<String> {
        Promise.value("")
    }
    
    func refreshAccessToken() -> Promise<Void> {
        Promise.value(())
    }
    
    func login(username: String, password: String) -> Promise<Void> {
        Promise.value(())
    }
    
    func signUp(email: String, password: String, username: String?) -> Promise<Void> {
        Promise.value(())
    }
    
    func signOut() {}
    
    func getUserInfo<T>(mapper: T.Type) -> Promise<T> where T: Decodable {
        Promise(error: AuthWrapperError.invalidUserPool)
    }
}
