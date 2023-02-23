//
//  UIVIewController.swift
//  UalaUtils_Example
//
//  Created by Andrés Abraham Bonilla Gómex on 20/09/21.
//  Copyright © 2021 Ualá. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    static var typeName: String {
        return String(describing: self)
    }
    
    func showMessage(title: String, message: Error, titleButton: String, completion: @escaping ((UIAlertAction) -> Void)) {
        let alertViewController: UIAlertController = UIAlertController(title: title, message: message.localizedDescription, preferredStyle: .alert)
        let alertAction: UIAlertAction = UIAlertAction(title: titleButton, style: .default, handler: completion)
        alertViewController.addAction(alertAction)
        present(alertViewController, animated: true, completion: nil)
    }
}
