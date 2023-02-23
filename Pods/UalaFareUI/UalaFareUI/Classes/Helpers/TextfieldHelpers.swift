//
//  TextfieldHelpers.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 30/08/2022.
//

extension UITextField {
    public func applyTypography(_ typography: TypographyStyle) {
        
        self.font = UIFont(family: typography.attributes.fontFamily, weight: typography.attributes.fontWeight, size: typography.attributes.fontSize)
        self.applyLineHeight(typography.attributes.lineHeight)
        self.applyLetterSpacing(typography.attributes.letterSpacing)
        self.applyTextCase(typography.attributes.textCase)
    }
    
    private func applyTextCase(_ textCase: TextCase) {
        
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
    
    private func applyLetterSpacing(_ letterSpacing: LetterSpacing) {
        
        self.applyAttributes([NSAttributedString.Key.kern: letterSpacing.value])
    }
    
    private func applyLineHeight(_ lineHeight: LineHeights) {

        let paragraphStyle = NSMutableParagraphStyle()
        var lineHeightString = lineHeight.value
        if lineHeight.value.hasSuffix("%") {
            lineHeightString.removeLast()
        }
        paragraphStyle.lineSpacing = 1
        paragraphStyle.lineHeightMultiple = (lineHeightString.toCGFloat() / 100)
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
