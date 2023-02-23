//
//  UIStackView.swift
//  UalaUI
//
//  Created by Alan Valencia on 05/07/22.
//

import UIKit

public extension UIStackView {
    
    public convenience init(axis: NSLayoutConstraint.Axis, alignment: Alignment = .fill, distribution: Distribution = .fill, spacing: CGFloat) {
        self.init()
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
    
    public func add(arrangedSubviews subviews: [UIView]) {
        for subview in subviews {
            addArrangedSubview(subview)
        }
    }
}
