//
//  EmailClients.swift
//  UalaCore
//
//  Created by Diego Palomares on 01/07/22.
//

enum EmailClients: String {
    case gmail = "googlegmail://"
    case outlook = "ms-outlook://"
    case yahoo = "ymail://"
    case spark = "readdle-spark://"
    case message = "message://"
    case mailto = "mailto:"
    
    var composeStruct: String? {
        switch self {
        case .gmail:
            return "co?to="
        case .outlook:
            return "compose?to="
        case .yahoo:
            return "mail/compose?to="
        case .spark:
            return "compose?recipient="
        case .message:
            return nil
        case .mailto:
            return ""
        }
    }
    
    var subjectStruct: String? {
        switch self {
        case .gmail, .outlook, .yahoo, .spark:
            return "&subject="
        case .mailto:
            return "?subject="
        case .message:
            return nil
        }
    }
    
    var bodyStruct: String? {
        switch self {
        case .gmail, .yahoo, .spark, .mailto:
            return "&body="
        case .message, .outlook:
            return nil
        }
    }
    
    func makeUrl(_ compose: String? = nil, subject: String? = nil, body: String? = nil) -> URL? {
        var url = self.rawValue
        if let compose = compose,
           let composeStruct = self.composeStruct {
            url += composeStruct + compose
        }
        
        if let subject = subject,
           let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let subjectStruct = self.subjectStruct {
            url += subjectStruct + subjectEncoded
        }
        
        if let body = body,
           let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let bodyStruct = self.bodyStruct {
            url += bodyStruct + bodyEncoded
        }
        
        return URL(string: url)
    }
}
