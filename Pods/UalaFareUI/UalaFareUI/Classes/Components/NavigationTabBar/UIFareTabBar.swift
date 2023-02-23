//
//  UIFareTabBar.swift
//  UalaFareUI
//
//  Created by Luis Perez on 29/09/22.
//

import UIKit

final class UIFareTabBar: UITabBar {
    private let theme: Theme
    private var shapeLayer: CALayer?
    private var gradientLayer: CAGradientLayer?
    private var shouldAddCentralButtonShape: Bool
    
    init(theme: Theme, frame: CGRect = .zero, shouldAddCentralButtonShape: Bool) {
        self.theme = theme
        self.shouldAddCentralButtonShape = shouldAddCentralButtonShape
        super.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        self.theme = MainThemeManager.shared
        self.shouldAddCentralButtonShape = false
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        self.theme = MainThemeManager.shared
        self.shouldAddCentralButtonShape = false
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShape()
    }
    
    public func addCentralButtonShape() {
        shouldAddCentralButtonShape = true
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    public func removeCentralButtonShape() {
        shouldAddCentralButtonShape = false
        shapeLayer?.removeFromSuperlayer()
    }

    private func addShape() {
        let shadow = Shadows.shadowLg
        let shapeLayer = CAShapeLayer()
        if shouldAddCentralButtonShape {
            shapeLayer.path = roundedCentralButtonPath()
        } else {
            shapeLayer.path = regularLayerPath()
        }
        shapeLayer.fillColor = theme.color(for: .neutralWhite).cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = shadow.attributes.blur
        shapeLayer.shadowColor = shadow.attributes.color.cgColor
        shapeLayer.shadowOpacity = 1
        
        let gradientLayer = CAGradientLayer()
        let bottomColor = UIColor(hex: "89A5FF").cgColor
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 72)
        gradientLayer.colors = [UIColor.white.cgColor, bottomColor]
        gradientLayer.locations = [0, 1]
        
        if let oldGradientLayer = self.gradientLayer {
            self.layer.replaceSublayer(oldGradientLayer, with: gradientLayer)
        } else {
            self.layer.insertSublayer(gradientLayer, at: 0)
        }

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 1)
        }
        
        self.gradientLayer = gradientLayer
        self.shapeLayer = shapeLayer
    }
    
    private func regularLayerPath() -> CGPath {
        let path = UIBezierPath()
        let initialPoint = CGPoint(x: 0, y: 0)
        let topRightPoint = CGPoint(x: bounds.width, y: 0)
        let bottomRightPoint = CGPoint(x: bounds.width, y: bounds.height)
        let bottomLeftPoint = CGPoint(x: 0, y: bounds.height)
        
        path.move(to: initialPoint)
        path.addLine(to: topRightPoint)
        path.addLine(to: bottomRightPoint)
        path.addLine(to: bottomLeftPoint)
        path.addLine(to: initialPoint)
        path.close()
        
        return path.cgPath
    }
    
    private func roundedCentralButtonPath() -> CGPath {
        // Properties to generate the curve
        let centralButtonWidth: CGFloat = 48
        let centralButtonSpacing: CGFloat = 6
        let curveSegmentWidth: CGFloat = 16
        let topArcsRadius: CGFloat = 16
        let bottomArcsRadius: CGFloat = 30
        let barCenterX: CGFloat = self.frame.midX
        let path = UIBezierPath()
        let firstLineDestinationPoint = CGPoint(x: barCenterX
                                                - centralButtonSpacing
                                                - curveSegmentWidth
                                                - centralButtonWidth / 2,
                                                y: 0)
        let topLeftArcCenterPoint = CGPoint(x: firstLineDestinationPoint.x,
                                            y: curveSegmentWidth)
        
        // Path start point
        path.move(to: CGPoint(x: 0,
                              y: 0))
        path.addLine(to: firstLineDestinationPoint)
        
        // This draw the first arc from top left to middle left
        path.addArc(withCenter: topLeftArcCenterPoint,
                    radius: topArcsRadius,
                    startAngle: -.pi * 0.5, endAngle: 0.0,
                    clockwise: true)
        
        let mainCircleCenterPoint = CGPoint(x: firstLineDestinationPoint.x
                                            + curveSegmentWidth
                                            + centralButtonSpacing
                                            + centralButtonWidth / 2,
                                            y: centralButtonWidth / 2 + 8)
        
        // This draw the seccond arc from middle left to middle right
        path.addArc(withCenter: mainCircleCenterPoint,
                    radius: bottomArcsRadius,
                    startAngle: .pi,
                    endAngle: 0.0,
                    clockwise: false)
        
        let topRightCircleCenterPoint = CGPoint(x: barCenterX + centralButtonSpacing + curveSegmentWidth + centralButtonWidth / 2,
                                                y: 16)
        
        // This draw the final arc from middle right to top right
        path.addArc(withCenter: topRightCircleCenterPoint,
                    radius: topArcsRadius,
                    startAngle: .pi,
                    endAngle: -.pi * 0.5,
                    clockwise: true)
        
        // This close the path to the begining of the drawing.
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }
}
