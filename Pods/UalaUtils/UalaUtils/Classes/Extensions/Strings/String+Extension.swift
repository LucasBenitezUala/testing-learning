//
//  String+Extension.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 06/10/21.
//

import Foundation

public extension String {
    
    func needle(needle: String, beforeNeedle: Bool = false) -> String? {
        
        guard let range = self.range(of: needle) else {
            return nil
        }
        
        return beforeNeedle ? String(self.prefix(upTo: range.lowerBound)) : String(self.suffix(from: range.upperBound))
    }
    
    func currencyInputFormatting(minFractionDigits: Int? = nil,
                                 maxFractionDigits: Int? = nil,
                                 currencySymbol: String = "$",
                                 localeIdentifier: String) -> String {
        var number: NSNumber = 0
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: localeIdentifier) as Locale
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = currencySymbol
        formatter.maximumFractionDigits = maxFractionDigits ?? 2
        formatter.minimumFractionDigits = minFractionDigits ?? 2
        
        var amountWithPrefix: String = self
        let range: NSRange = NSMakeRange(0, self.count)
        
        // remove from String: "$", ".", ","
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix,
                                                              options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                              range: range,
                                                              withTemplate: "")
            
            let double: Double = (amountWithPrefix as NSString).doubleValue
            let ratio: Double = maxFractionDigits == nil ? Double(100) : pow(Double(10), Double(maxFractionDigits ?? 0))
            number = NSNumber(value: (double / ratio))
            
            // if first number is 0 or all numbers were deleted
            guard number != 0 as NSNumber,
                  let currency: String = formatter.string(from: number) else {
                return ""
            }
            
            return currency
        } catch {
            return ""
        }
    }
    
    func removeSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func convertCurrencyToDouble(minFractionDigits: Int = 2,
                                 maxFractionDigits: Int = 2,
                                 currencySymbol: String = "$",
                                 localeIdentifier: String) -> Double {
        var formatter: NumberFormatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: localeIdentifier) as Locale
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = currencySymbol
        formatter.maximumFractionDigits = maxFractionDigits
        formatter.minimumFractionDigits = minFractionDigits
        
        let amountWithPrefix: String = self
        
        if let number: NSNumber = formatter.number(from: amountWithPrefix) {
            return number.doubleValue
        }
        
        let convertDouble = convertCurrencyToDouble(formatter: &formatter, separador: ",") ??
                           convertCurrencyToDouble(formatter: &formatter, separador: ".")
        return convertDouble ?? 0
    }
    
    func convertCurrencyToDouble(formatter: inout NumberFormatter, separador: String) -> Double? {
        formatter.locale = .current
        formatter.usesGroupingSeparator = true
        formatter.currencyDecimalSeparator = separador
        return formatter.number(from: self)?.doubleValue ?? 0
    }
    
    func removeDiacritics() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
}
