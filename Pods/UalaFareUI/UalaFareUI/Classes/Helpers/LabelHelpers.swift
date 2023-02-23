//
//  UalaLabel.swift
//  UalaDSDemo
//
//  Created by Matías Schwalb on 28/06/2022.
//

import UIKit

extension UILabel {
    public func applyTypography(_ typography: TypographyStyle) {        
        guard let customFont = UIFont(family: typography.attributes.fontFamily,
                                      weight: typography.attributes.fontWeight,
                                      size: typography.attributes.fontSize)
        else {
            return
        }
        
        // We need to store the typography.
        if let linkeableLabel = self as? UIFareLinkeableLabel {
            linkeableLabel.typography = typography
        }
        
        self.font = customFont
        self.applyLineHeight(typography.attributes.lineHeight,
                             fontSize: typography.attributes.fontSize.rawValue)
        self.applyLetterSpacing(typography.attributes.letterSpacing)
        self.applyTextCase(typography.attributes.textCase)
    }
    
    func applyTextCase(_ textCase: TextCase) {
        
        switch textCase {
        case .textCaseUpper:
            self.text = self.text?.uppercased()
        case .textCaseLower:
            self.text = self.text?.lowercased()
        case .textCaseCapitalize:
            self.text = self.text?.capitalized
        case .textCaseNone:
            break
        }
    }
    
    func applyLetterSpacing(_ letterSpacing: LetterSpacing) {
        
        self.applyAttributes([NSAttributedString.Key.kern: letterSpacing.value])
    }
    
    func applyLineHeight(_ lineHeight: LineHeights, fontSize: CGFloat) {

        let paragraphStyle = NSMutableParagraphStyle()
        var lineHeightString = lineHeight.value
        if lineHeight.value.hasSuffix("%") {
            lineHeightString.removeLast()
        }
        paragraphStyle.lineSpacing = (lineHeightString.toCGFloat() / 100)
        paragraphStyle.maximumLineHeight = fontSize
        self.applyAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    private func applyAttributes(_ attributes: [NSAttributedString.Key: Any]) {
        
        let mutableString = NSMutableAttributedString(attributedString: self.attributedText ?? NSAttributedString(string: self.text ?? ""))
        
        attributes.forEach { (key, value) in
            mutableString.addAttribute(key, value: value, range: NSRange(location: 0, length: mutableString.length))
        }
        
        attributedText = mutableString
    }
}
