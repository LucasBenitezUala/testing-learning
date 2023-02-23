//
//  BancarTextField.swift
//  Uala
//
//  Created by Nicolas on 27/07/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import UIKit
import UalaCore

open class BancarTextField: UITextField {
    var titleLabel: UILabel!
    var lineView: UIView!
    private var showPasswordButton: UIButton!

    var backupActiveLineColor: UIColor!
    var backupLineColor: UIColor!

    var lineColor: UIColor = UalaStyle.colors.grey70
    var activeLineColor: UIColor = UalaStyle.colors.blue50
    public var placeholderText: String = ""
    public var leftIconView: UIView! = UIView()
    var placeholderActiveFont: UIFont = UIFont.regular(size: 17)
    var placeholderActiveColor: UIColor = .black
    public var subLabel: UILabel!
    private var placeholderFrame: CGRect?
    private var subLabelText: String?
    var lastValue: String?
    public var style: BancarTextFieldStyle?
    private var placeholderLabel: UILabel? { getPlaceholderLabel() }
    private lazy var backupInset: CGFloat = 35.0
    private var animateRequestTimes = 0
    public var isError: Bool = false {
        willSet {
            updateErrorMessageIfNecessary(status: newValue)
        }
    }
    public var leftInset: CGFloat = 35.0 {
        didSet {
            updateBackupInsetOnFocus()
        }
    }
    public var customTitle: String = ""
    override open var text: String? {
        didSet {
            animatePlaceholderFocus(duration: .zero)
        }
    }

    // MARK: - Constructors

    override open func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customizeUI()
    }

    // MARK: - UI Initialization

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        configure()
    }

    open func customize(style: BancarTextFieldStyle) {
        self.style = style
        font = style.font
        tintColor = style.tintColor
        textColor = style.textColor
        textAlignment = style.textAlignment
        lineColor = style.lineColor
        placeholderActiveFont = style.placeholderActiveFont
        placeholderActiveColor = style.placeholderActiveColor
        activeLineColor = style.activeLineColor
        backupActiveLineColor = style.activeLineColor
        backupLineColor = style.lineColor
    }

    private func customizeUI() {
        backgroundColor = .clear

        titleLabel = UILabel()
        titleLabel.isHidden = true
        titleLabel.textAlignment = textAlignment
        addSubview(titleLabel)

        addTarget(self, action: #selector(textfieldDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(textfieldDidEnd), for: .editingDidEnd)
        addTarget(self, action: #selector(textfieldEditingChanged), for: .editingChanged)

        lineView = UIView()
        addSubview(lineView)

        customizeConstraints()
        customizeLabel()
    }
    
    open func configure() {
        let title: String = !customTitle.isEmpty ? customTitle : placeholderText
        titleLabel.text = title
        titleLabel.font = placeholderActiveFont
        titleLabel.textColor = placeholderActiveColor
        placeholder = isFirstResponder ? nil : placeholderText
        leftView = leftIconView
        lineView.backgroundColor = self.text.isEmpty ? lineColor : activeLineColor
    }

    internal func customizeLabel() {
        subLabel = UILabel()
        subLabel.numberOfLines = 0
        addSubview(subLabel)

        subLabel.autoPinEdge(toSuperviewEdge: .left)
        subLabel.autoPinEdge(toSuperviewEdge: .right)
        subLabel.autoPinEdge(.top, to: .bottom, of: lineView, withOffset: 5)
    }

    private func customizeConstraints() {
        titleLabel.autoPinEdge(toSuperviewEdge: .left)
        titleLabel.autoPinEdge(toSuperviewEdge: .right)
        titleLabel.autoPinEdge(toSuperviewEdge: .top)

        lineView.autoSetDimension(.height, toSize: 1)
        lineView.autoPinEdge(toSuperviewEdge: .left)
        lineView.autoPinEdge(toSuperviewEdge: .right)
        lineView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
    }

    // MARK: - UI Events

    @objc open func textfieldDidBegin() {
        animatePlaceholderFocus(duration: placeholderAnimationDuration)
        leftViewMode = .never
        lineView.backgroundColor = activeLineColor
    }

    @objc public func textfieldEditingChanged() {
        setError(isError: false)
        if let text = text, text.isEmpty {
            placeholder = placeholderText
            leftViewMode = .never
            titleLabel.isHidden = false
            waitToFinishAnimationChanges()
            placeholderLabel?.isHidden = true
            animatePlaceholderFocus(duration: 0)
        }
    }

    @objc public func textfieldDidEnd() {
        if let text = text, text.isEmpty {
            animatePlaceholderLosesFocus(duration: placeholderAnimationDuration)
            leftViewMode = text.isEmpty ? .always : .never
            lineView.backgroundColor = text.isEmpty ? lineColor : activeLineColor
        }
    }

    // MARK: - Error handling

    public func setError(isError: Bool) {
        self.isError = isError
        activeLineColor = isError ? UalaStyle.colors.red50 : backupActiveLineColor
        lineColor = isError ? UalaStyle.colors.red50 : backupLineColor
        lineView.backgroundColor = activeLineColor
        titleLabel.textColor = isError ? UalaStyle.colors.red50 : placeholderActiveColor
        subLabel.textColor = isError ? UalaStyle.colors.red50 : style?.textColor ?? backupActiveLineColor
    }

    public func setError(isError: Bool, text: String?) {
        setError(isError: isError)
        if let string = text {
            subLabel.text = string
        }
    }

    // MARK: - Place holder methods

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 5)

        return bounds.inset(by: padding)
    }
}

// MARK: - Placeholder Animation

private extension BancarTextField {
    var leftInsetSentinel: CGFloat { -1.0 }
    var placeholderAnimationDuration: TimeInterval { 0.2 }

    func updateBackupInsetOnFocus() {
        guard leftInset != leftInsetSentinel else {
            return
        }

        backupInset = leftInset
    }

    func animatePlaceholderFocus(duration: TimeInterval) {
        guard let placeHolderLabel: UILabel = placeholderLabel,
              let style: BancarTextFieldStyle = style else {
                  titleLabel.isHidden = false
                  return
              }
        placeholderFrame = placeHolderLabel.layer.frame

        animateRequestTimes = 1
        animate(label: placeHolderLabel,
                font: style.placeholderActiveFont,
                fontColor: style.placeholderActiveColor,
                duration: duration,
                frame: titleLabel.frame,
                completion: { [weak self, weak placeHolderLabel] in

            self?.titleLabel.isHidden = false
            placeHolderLabel?.isHidden = true

            self?.animateRequestTimes -= 1
            if let self = self, self.animateRequestTimes > 0 {
                self.animateRequestTimes = 0
                self.animatePlaceholderLosesFocus(duration: duration)
            }
        })
    }
    
    func animatePlaceholderLosesFocus(duration: TimeInterval) {
        guard let destinationFrame: CGRect = placeholderFrame,
              let placeHolderLabel: UILabel = placeholderLabel,
              let style: BancarTextFieldStyle = style else {
                  return
              }

        placeHolderLabel.isHidden = false
        placeHolderLabel.layer.frame = titleLabel.frame
        titleLabel.isHidden = true
        animateRequestTimes += 1

        animate(label: placeHolderLabel,
                font: style.font,
                fontColor: style.placeholderColor,
                duration: duration,
                frame: destinationFrame,
                leftInset: backupInset,
                completion: { [weak self, weak placeHolderLabel] in
            placeHolderLabel?.isHidden = false
            self?.leftInset = self?.backupInset ?? self?.leftInsetSentinel ?? .zero
            self?.animateRequestTimes -= 1
            if let self = self, self.animateRequestTimes > 0 {
                self.animateRequestTimes = 0
                self.animatePlaceholderFocus(duration: duration)
            }
        })
    }

    func animate(label: UILabel,
                 font: UIFont,
                 fontColor: UIColor,
                 duration: TimeInterval,
                 frame: CGRect,
                 leftInset: CGFloat? = nil,
                 completion: @escaping () -> Void) {
        self.leftInset = leftInset ?? leftInsetSentinel

        label.animateFontChange(font,
                                toColor: fontColor,
                                duration: duration)

        label.layer.animatedMove(to: frame,
                                 duration: duration,
                                 completion: completion)
    }

    private func waitToFinishAnimationChanges() {
        RunLoop.current.run(until: Date())
    }
}

// MARK: - Error handling

extension BancarTextField {
    func updateErrorMessageIfNecessary(status: Bool) {
        guard status != isError else { return }
        
        if status, let text = subLabel.text, !text.isEmpty {
            subLabelText = subLabel.text
        } else {
            subLabel?.text = subLabelText
        }
    }

    func getPlaceholderLabel() -> UILabel? {
        let textFieldLabelClassName: String = "UITextFieldLabel"

        return subviews.first { NSStringFromClass(type(of: $0)) == textFieldLabelClassName } as? UILabel
    }
}
