//
//  UILabel+Attributed.swift
//  UalaUI
//
//  Created by Francisco Javier Saldivar Rubio on 06/05/22.
//
import UIKit

extension UILabel {
    
    /// Description
    /// - Parameter elements: list of customized attributes words
    func setAttributes(elements: [UalaAttributedString]) {
        guard let text = text as NSString? else { return }
        let attributedString = addLineBreak(self.attributedText ?? NSAttributedString() )
        var isUnClickable: Bool = true
        for element in elements {
            let range = text.range(of: element.word)
            attributedString.setAttributes(element.getAttributes(), range: range)
            if isUnClickable && element.delegate != nil {
                self.addGestureRecognizer(UalaLabelTapGesture.init(label: self, elements: elements))
                self.isUserInteractionEnabled = true
                isUnClickable = false
            }
        }
    
        self.attributedText = attributedString
    }
    
    /// add line break mode
    private func addLineBreak(_ attrString: NSAttributedString) -> NSMutableAttributedString {
        let mutAttrString = NSMutableAttributedString(attributedString: attrString)
        
        var range = NSRange(location: 0, length: 0)
        var attributes = mutAttrString.attributes(at: 0, effectiveRange: &range)
        
        let paragraphStyle = attributes[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        paragraphStyle.alignment = textAlignment
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        mutAttrString.setAttributes(attributes, range: range)
        
        return mutAttrString
    }
}
