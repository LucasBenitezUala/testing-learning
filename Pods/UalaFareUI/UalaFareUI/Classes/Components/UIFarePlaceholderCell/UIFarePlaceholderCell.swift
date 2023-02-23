//
//  PlaceholderCell.swift
//  UalaFareUI
//
//  Created by Luis Perez on 10/08/22.
//

import UIKit

open class UIFarePlaceholderCell: UITableViewCell {
    private var animatedGradientLayer: CAGradientLayer?
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard let animatedGradientLayer = animatedGradientLayer else {
            return
        }
        
        animatedGradientLayer.frame = contentView.bounds
        animateGradientLayer(layer: animatedGradientLayer)
    }
    
    open func configurePlaceholder(theme: Theme) {
        configureCell()
        setupAnimatedLayerIfNeeded(theme: theme)
        overrideSubviewsBackgroundColor(with: theme.color(for: .neutralLight))
    }
    
    private func configureCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setupAnimatedLayerIfNeeded(theme: Theme) {
        if animatedGradientLayer == nil {
            let layer = CAGradientLayer()
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
            layer.frame = contentView.bounds
            layer.startPoint = CGPoint(x: 0.0, y: 0.0)
            layer.endPoint = CGPoint(x: 1.0, y: 0.0)
            layer.locations = [0.0, 0.3, 1.0]
            layer.colors = [
                theme.color(for: .neutralLight).withAlphaComponent(0).cgColor,
                UIColor.white.cgColor,
                theme.color(for: .neutralLight).withAlphaComponent(0).cgColor]
            contentView.layer.addSublayer(layer)
            animatedGradientLayer = layer
        }
    }
    
    private func overrideSubviewsBackgroundColor(with backgroundColor: UIColor) {
        for subview in contentView.subviews {
            if let stackView = subview as? UIStackView {
                for stackSubview in stackView.arrangedSubviews {
                    stackSubview.backgroundColor = backgroundColor
                }
            } else {
                subview.backgroundColor = backgroundColor
            }
        }
    }
    
    private func animateGradientLayer(layer: CAGradientLayer) {
        layer.removeAllAnimations()
        layer.position.x -= layer.frame.width
        
        let initialValue = layer.position.x
        let finalValue = layer.position.x + layer.frame.width * 2
        
        CATransaction.setDisableActions(true)
        layer.position.x = finalValue
        
        let animation = CABasicAnimation(keyPath: "position.x")
        
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = true
        animation.autoreverses = false
        animation.fromValue = initialValue
        animation.toValue = finalValue
        animation.duration = 1
        layer.add(animation, forKey: "Reposition")
    }
    
    private func areSubviewsSized() -> Bool {
        let subviews = contentView.subviews
        for view in subviews {
            if let stack = view as? UIStackView {
                for subview in stack.arrangedSubviews where subview.frame.height > 0 {
                    return true
                }
            } else if view.frame.height > 0 {
                return true
            }
        }
        return false
    }
}
