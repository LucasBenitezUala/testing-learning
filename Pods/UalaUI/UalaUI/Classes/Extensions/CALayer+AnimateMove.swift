//
//  CALayer+AnimatedMove.swift
//  UalaUI
//
//  Created by Ualá on 07/10/21.
//

import CoreGraphics

public extension CALayer {

    private var positionKeyPath: String { "position" }
    private var frameKeyPath: String { "frame" }

    public func animatedMove(to frame: CGRect, duration: TimeInterval = 0.2, completion: @escaping () -> Void = { }) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)

        let animation = CABasicAnimation(keyPath: positionKeyPath)
        animation.fromValue = value(forKey: positionKeyPath)
        animation.toValue = NSValue(cgPoint: CGPoint(x: frame.midX, y: frame.midY))
        animation.fillMode = .forwards
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.isRemovedOnCompletion = false

        self.position = CGPoint(x: frame.midX, y: frame.midY)
        add(animation, forKey: positionKeyPath)
        CATransaction.commit()
    }
}
