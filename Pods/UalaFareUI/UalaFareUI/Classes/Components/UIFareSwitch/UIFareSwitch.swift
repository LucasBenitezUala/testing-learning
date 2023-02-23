//
//  UIFareSwitch.swift
//  UalaFareUI
//
//  Created by Luis Perez on 29/08/22.
//

import UIKit

@IBDesignable
public final class UIFareSwitch: UIControl {
    
    @IBInspectable
    public var isOn: Bool = false {
        didSet {
            updateSwitchStatus()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            updateSwitchStatus()
        }
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var thumbView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var theme: UIFareSwitchModel = MainThemeManager.shared.toggleThemedModel()
    private var thumbLeadingConstraint: NSLayoutConstraint!
    private var offLeadingConstant: CGFloat = .zero
    private var onLeadingConstant: CGFloat = .zero
    private let hapticGenerator = UINotificationFeedbackGenerator()
    private var isAnimating = false
    
    // Intrinsic content size has no implementation in custom views.
    public override var intrinsicContentSize: CGSize {
        return bounds.size
    }
    
    public init(theme: UIFareSwitchModel, frame: CGRect = .zero) {
        self.theme = theme
        super.init(frame: frame)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // NOTE: When overriding this initializer, you need to override the init(frame), otherwise the IB will crash
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        configureLayout(containerFrame: rect)
        configureSwitchColors()
        roundViews(containerFrame: rect)
        configureGestureRecognizer()
    }
    
    private func configureLayout(containerFrame: CGRect) {
        let thumbSize = CGSize(width: containerFrame.height - 8,
                               height: containerFrame.height - 8)

        offLeadingConstant = 4
        onLeadingConstant = containerFrame.width - 4 - thumbSize.width
        
        self.addSubview(backgroundView)
        backgroundView.addSubview(thumbView)

        thumbLeadingConstraint = thumbView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                                    constant: isOn ? onLeadingConstant : offLeadingConstant)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            thumbView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            thumbView.heightAnchor.constraint(equalToConstant: thumbSize.height),
            thumbView.widthAnchor.constraint(equalToConstant: thumbSize.width),
            thumbLeadingConstraint
        ])
    }
    
    private func updateSwitchStatus() {
        configureSwitchColors()
        configureThumbPositon()
    }
    
    private func configureSwitchColors() {
        self.backgroundColor = .clear
        thumbView.backgroundColor = theme.thumbColor
        
        if isEnabled {
            backgroundView.backgroundColor = isOn ? theme.onColor : theme.offColor
        } else {
            backgroundView.backgroundColor = isOn ? theme.disabledOnColor : theme.disabledOffColor
        }
    }
    
    private func configureThumbPositon() {
        isAnimating = true
        self.layoutIfNeeded()
        thumbLeadingConstraint?.constant = isOn ? onLeadingConstant : offLeadingConstant
        self.setNeedsLayout()
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseOut, .beginFromCurrentState]) { [weak self] in
            self?.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.isAnimating = false
        }
    }
    
    private func roundViews(containerFrame: CGRect) {
        self.thumbView.layer.cornerRadius = (containerFrame.height - 8) / 2
        self.backgroundView.layer.cornerRadius = containerFrame.height / 2
    }
    
    private func configureGestureRecognizer() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                                      action: #selector(didTouchDown(gesture:)))
        longPressGestureRecognizer.minimumPressDuration = 0.01
        thumbView.isUserInteractionEnabled = false
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc private func didTouchDown(gesture: UILongPressGestureRecognizer) {
        if !isAnimating {
            hapticGenerator.prepare()
            if gesture.state == .ended {
                isOn = !isOn
                hapticGenerator.notificationOccurred(.success)
                sendActions(for: .valueChanged)
            }
        }
    }
}
