//
//  UIColorExtension.swift
//  UalaDSDemo
//
//  Created by Matías Schwalb on 14/06/2022.
//

import UIKit.UIColor

extension UIColor {
    
    convenience init(hex: String) {
        var hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count == 3 {
            var fullString = ""
            for char in hexString {
                fullString.append(char)
                fullString.append(char)
            }
            hexString = fullString
        }
        
        if hexString.count == 6 {
            hexString.append("FF")
        }
        
        if hexString.count != 8 {
            self.init(red: 0, green: 0, blue: 0, alpha: 0) // Fallback value
            return
        }
        
        let scanner = Scanner(string: hexString)
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x00000000FF
        let rValue = Int(color >> 24) & mask
        let gValue = Int(color >> 16) & mask
        let bValue = Int(color >> 8) & mask
        let aValue = Int(color) & mask
        let red   = CGFloat(rValue) / 255.0
        let green = CGFloat(gValue) / 255.0
        let blue  = CGFloat(bValue) / 255.0
        let alpha = CGFloat(aValue) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
