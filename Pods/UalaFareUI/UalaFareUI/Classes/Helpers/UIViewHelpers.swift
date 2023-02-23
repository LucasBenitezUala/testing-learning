//
//  IUViewHelpers.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 30/08/2022.
//

public extension UIView {
    func applyBorder(width: BorderWidth, color: UIColor?) {
        self.layer.borderWidth = width.value
        self.layer.borderColor = color?.cgColor
    }
    
    func applyCornerRadius(_ radius: BorderRadius) {
        self.layoutIfNeeded()
        let cRadius: CGFloat
        if radius.value.hasSuffix("%") {
            var dividerString = radius.value
            dividerString.removeLast()
            if dividerString.toCGFloat() != 0 {
                let divider = 2 / (dividerString.toCGFloat() / 100.0)
                cRadius = self.bounds.width / divider
            } else {
                cRadius = 0
            }
        } else {
            cRadius = radius.value.toCGFloat()
        }
        
        self.layer.cornerRadius = cRadius
    }
    
    func applyShadow(_ shadow: Shadows) {
        self.layoutIfNeeded()
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = shadow.attributes.color.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: shadow.attributes.xCoordinate, y: shadow.attributes.yCoordinate, width: self.bounds.width, height: self.bounds.height), cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowRadius = shadow.attributes.blur / 10
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
