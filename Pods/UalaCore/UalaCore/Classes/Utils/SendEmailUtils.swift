//
//  SendEmailUtils.swift
//  UalaCore
//
//  Created by Monserrath Castro on 16/06/21.
//

import Foundation
import MessageUI

public class SendEmailUtils {
    
    public static func sendEmail(
        recipient: String? = nil,
        subject: String? = nil,
        body: String? = nil,
        delegate: MFMailComposeViewControllerDelegate?,
        _ completionHandler: @escaping (MFMailComposeViewController?, URL?) -> Void
    ) {
        if MFMailComposeViewController.canSendMail() {
            let email = MFMailComposeViewController()
            email.mailComposeDelegate = delegate

            if let recipient = recipient {
                email.setToRecipients([recipient])
            }

            if let subject = subject {
                email.setSubject(subject)
            }

            completionHandler(email, nil)
        } else if let emailUrl = self.createEmailUrl(recipient: recipient, subject: subject, body: body) {
            completionHandler(nil, emailUrl)
        } else {
            completionHandler(nil, nil)
        }
    }
    
    public static func createEmailUrl(recipient: String? = nil, subject: String? = nil, body: String? = nil) -> URL? {
        let emailClients: [EmailClients] = [.gmail, .outlook, .yahoo, .spark, .mailto, .message]
        
        for client in emailClients {
            if let url = client.makeUrl(recipient, subject: subject, body: body) , UIApplication.shared.canOpenURL(url) {
                return url
            }
        }
        
        return nil
    }
}
