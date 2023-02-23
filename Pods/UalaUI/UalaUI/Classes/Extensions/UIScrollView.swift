//
//  UIScrollView.swift
//  Uala
//
//  Created by Hasael Oliveros on 7/18/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import UIKit

public extension UIScrollView {
    
    /// listen to keyboard event
    func makeAwareOfKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// remove observer
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// move scroll view up
    @objc func keyboardWillShow(notification: Notification) {
        guard let rectValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardSize = rectValue.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
        self.contentInset = contentInsets
        self.scrollIndicatorInsets = contentInsets
    }
    
    /// move scrollview back down
    @objc func keyboardWillHide(notification: Notification) {
        // restore content inset to 0
        self.contentInset = UIEdgeInsets.zero
        self.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    func scrollToBottom(animated: Bool) {
        let rect = CGRect(x: 0, y: contentSize.height - bounds.size.height, width: bounds.size.width, height: bounds.size.height)
        scrollRectToVisible(rect, animated: animated)
    }
}
