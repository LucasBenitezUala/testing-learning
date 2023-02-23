//
//  StringExtensions.swift
//  UalaDSDemo
//
//  Created by Matías Schwalb on 21/06/2022.
//

import UIKit

extension String {
    func toCGFloat() -> CGFloat {
        guard let doubleValue = Double(self) else {
            return 0
        }
        
        return CGFloat(doubleValue)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
    
    func currencyInputFormatting(minFractionDigits: Int = 0,
                                 maxFractionDigits: Int = 0,
                                 currencySymbol: String = "$",
                                 localeIdentifier: String) -> String {
        
        let locale = Locale.current
        
        guard let decimalSeparator = locale.decimalSeparator,
              let thousandsSeparator = locale.groupingSeparator,
              !self.hasSuffix(decimalSeparator) else {
            return self
        }
    
        // removing all characters from string before formatting
        let stringWithoutSymbol = self.replacingOccurrences(of: "$", with: "")
        let stringWithoutComma = stringWithoutSymbol.replacingOccurrences(of: thousandsSeparator, with: "")

        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.currencySymbol = currencySymbol
        formatter.locale = locale
        formatter.roundingMode = .down
        formatter.numberStyle = .currency
        
        if let double = Double(stringWithoutComma), let finalString = formatter.string(from: NSNumber(value: double)) {
            return finalString
        }
        
        return self.isEmpty ? "0" : self
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func removeCurrency(symbol: String) -> String {
        return self.replacingOccurrences(of: symbol, with: "")
    }
}
