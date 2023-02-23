//
//  CircularProgressView.swift
//  UalaUI
//
//  Created by Juan Ignacio Fernandez on 19/10/2021.
//

import Foundation

public class CircularProgressBar: UIView {
    
    private let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
    private var baseLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    private let speed: TimeInterval = 2
    private var progress: Double = 0
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
        
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        let baseColor = UalaStyle.colors.blue20
        let progressColor = UalaStyle.colors.blue50
        let progressWidth: CGFloat = 1.5
        let half: CGFloat = 0.5
        let radius: CGFloat = CGFloat(bounds.width) * half - progressWidth * half
        
        configure(duration: speed,
                  startPoint: startPoint,
                  endPoint: endPoint,
                  clockwise: true,
                  progressColor: progressColor,
                  progressWidth: progressWidth,
                  baseColor: baseColor,
                  baseWidth: progressWidth,
                  radius: radius,
                  progress: 1.0)
        
        layer.addSublayer(baseLayer)
        layer.addSublayer(progressLayer)

        updateAnimation()
    }
    
    public func configure(duration: TimeInterval, progress: Double? = nil) {
        setProgress(progress: progress)
        progressLayer.duration = duration
        updateAnimation()
    }
    
    // swiftlint:disable:next function_parameter_count
    public func configure(duration: TimeInterval,
                          startPoint: CGFloat,
                          endPoint: CGFloat,
                          clockwise: Bool,
                          progressColor: UIColor,
                          progressWidth: CGFloat,
                          baseColor: UIColor,
                          baseWidth: CGFloat,
                          radius: CGFloat,
                          progress: Double? = nil) {
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: radius, startAngle: startPoint, endAngle: endPoint, clockwise: clockwise)

        baseLayer.path = circularPath.cgPath
        baseLayer.fillColor = UIColor.clear.cgColor
        baseLayer.lineCap = .round
        baseLayer.lineWidth = baseWidth
        baseLayer.strokeEnd = 1.0
        baseLayer.strokeColor = baseColor.cgColor

        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = progressWidth
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = progressColor.cgColor

        setProgress(progress: progress)
        updateAnimation()
    }
    
    public func start(progress: Double? = nil) {
        guard progress != self.progress else { return }
        setProgress(progress: progress)
        updateAnimation()
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
    
    private func setProgress(progress: Double? = nil) {
        guard let value = progress else { return }
        self.progress = value
    }
    
    private func updateAnimation() {
        circularProgressAnimation.duration = speed * progress
        circularProgressAnimation.toValue = progress
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
    }
    
    public struct CircularProgressBarConfiguration {
        let duration: TimeInterval
        let startPoint: CGFloat
        let endPoint: CGFloat
        let clockwise: Bool
        let progressColor: UIColor
        let progressWidth: CGFloat
        let baseColor: UIColor
        let baseWidth: CGFloat
        let radius: CGFloat
        let progress: Double?
    }
}
