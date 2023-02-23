//
//  UIControl.swift
//  UalaUI
//
//  Created by Aldana Rastrelli on 09/05/2022.
//

import Foundation

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping() -> Void) {
        
        if #available(iOS 14.0, *) {
            addAction(UIAction { (_: UIAction) in closure() }, for: controlEvents)
        } else {
            @objc class ClosureSleeve: NSObject {
                let closure: () -> Void
                init(_ closure: @escaping() -> Void) { self.closure = closure }
                @objc func invoke() { closure() }
            }
            let sleeve = ClosureSleeve(closure)
            addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
            objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}
