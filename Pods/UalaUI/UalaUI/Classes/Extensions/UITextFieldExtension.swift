//
//  UITextFieldExtension.swift
//  UalaUI
//
//  Created by uala on 01/09/21.
//

import Foundation

public extension UITextField {

    func modifyClearButtonWithImage(image: UIImage) {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(image, for: .normal)
        clearButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        clearButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        clearButton.contentMode = .scaleAspectFit
        self.rightView = clearButton
        self.rightViewMode = .whileEditing
    }
}
