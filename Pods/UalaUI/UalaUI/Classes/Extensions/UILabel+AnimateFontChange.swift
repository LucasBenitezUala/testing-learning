//
//  UILabel+AnimateFontChange.swift
//  UalaUI
//
//  Created by Ualá on 07/10/21.
//

import UIKit

extension UILabel {

    func animateFontChange(_ font: UIFont, toColor color: UIColor? = nil, duration: TimeInterval) {
        let oldFrame: CGRect = frame
        let labelScale: CGFloat = self.font.pointSize / font.pointSize
        self.font = font
        let oldTransform: CGAffineTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        let newOrigin: CGPoint = frame.origin
        frame.origin = oldFrame.origin

        setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration) { [weak self] in
            self?.transform = oldTransform
            self?.layoutIfNeeded()

            if let color = color {
                self?.textColor = color
            }
        }
    }
}
