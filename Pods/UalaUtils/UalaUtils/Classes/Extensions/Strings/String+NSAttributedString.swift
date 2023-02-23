//
//  String+NSAttributedString.swift
//  UalaUtils
//
//  Created by Mario García on 08/10/21.
//

import Foundation
import UIKit

public extension String {
    
    func applyFonts(toStrings strings: [String], baseFont: UIFont, secondaryFont: UIFont) -> NSAttributedString {
        let baseFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: baseFont]
        let secondaryFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: secondaryFont]
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self as String, attributes: baseFontAttribute)
        
        strings.forEach { string in
            attributedString.addAttributes(secondaryFontAttribute, range: (self as NSString).range(of: string as String))
        }
        
        return attributedString
    }
    
    func attributedStringWithColorSize(color: UIColor,
                                       size: CGFloat = 20,
                                       lengthToAttribute: Int = 2,
                                       font: UIFont? = nil
    ) -> NSAttributedString {
        let font = font ?? UIFont.systemFont(ofSize: size)
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        if self.count < (lengthToAttribute + 1) {
            return attributedString
        }
        let range: NSRange = NSRange(location: self.count-lengthToAttribute, length: lengthToAttribute)
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        return attributedString
    }
}
