//
//  UalaInput.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 15/07/2022.
//

import UIKit

public class UalaTextField: UITextField {

    // MARK: - Properties
    private var lineView: UIView!
    private var placeholderColor: UIColor!
    private var leftImageView: UIImageView?
    private var rightIconButton: UIFareButton?
    
    private var theme: TextFieldTheme
    
    var defaultTextFieldState: TextFieldState
    
    var textFieldState: TextFieldState {
        didSet {
            updateUI(for: textFieldState)
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            setState(isEnabled ? TextFieldState.idle : TextFieldState.disabled)
        }
    }

    // MARK: - Lifecycle and setups
    
    init(theme: TextFieldTheme, initialState: TextFieldState = .idle) {
        self.theme = theme
        self.textFieldState = initialState
        self.defaultTextFieldState = initialState
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    // MARK: - Theme
    
    public func setTheme(_ theme: TextFieldTheme) {
        self.theme = theme
        setState(.idle)
    }
    
    private func setupUI() {
        backgroundColor = .clear
        borderStyle = .none
        
        self.applyTypography(theme.typography)
        
        lineView = UIView()
        addSubview(lineView)
        
        updateUI(for: textFieldState)

        setupConstraints()
        setupSideImages()
        self.delegate = self
    }

    private func setupSideImages() {
        if let leftIcon = theme.leftIcon {
            self.leftViewMode = .always
            let leftPadding = UIView()
            leftPadding.backgroundColor = .clear
            leftPadding.widthAnchor.constraint(equalToConstant: 8).isActive = true
            let rightPadding = UIView()
            rightPadding.backgroundColor = .clear
            rightPadding.widthAnchor.constraint(equalToConstant: 8).isActive = true
            let leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            leftImageView.image = UIImage(withAsset: leftIcon)
            leftImageView.applyTintColor(theme.idlePlaceholderColor)
            let stack = UIStackView(arrangedSubviews: [leftPadding, leftImageView, rightPadding])
            self.leftView = stack
        } else {
            self.leftViewMode = .never
        }

        if let rightIcon = theme.rightIcon {
            self.rightViewMode = .always
            let buttonTheme = MainThemeManager.shared.buttonTheme(for: .iconOnly(isOnDarkBackground: false))
            let rightIconButton = UIFareButton(theme: buttonTheme, frame: .zero)
            rightIconButton.setImage(UIImage(withAsset: rightIcon), for: [])
            self.addSubview(rightIconButton)
            self.sendSubviewToBack(rightIconButton)
            NSLayoutConstraint.activate([
                self.trailingAnchor.constraint(equalTo: rightIconButton.trailingAnchor, constant: -28),
                self.centerYAnchor.constraint(equalTo: rightIconButton.centerYAnchor),
                rightIconButton.widthAnchor.constraint(equalToConstant: 48),
                rightIconButton.heightAnchor.constraint(equalToConstant: 48)
            ])

            self.rightIconButton = rightIconButton
            self.rightView = rightIconButton
        } else {
            self.rightViewMode = .never
        }
    }
    
    private func setupPlaceholder() {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: placeholderColor ?? .clear,
            NSAttributedString.Key.font: UIFont(family: .fontFamilyPrimary, weight: .fontWeightRegular, size: .fontSize3) ?? .systemFont(ofSize: 12)
        ]
        
        attributedPlaceholder = NSAttributedString(string: theme.placeholder ?? "", attributes: attributes)
    }
    
    // MARK: - State
    
    private func setState(_ state: TextFieldState) {
        self.textFieldState = state
        if state != .error {
            self.defaultTextFieldState = state
        }
    }
    
    public func setError(_ value: Bool) {
        setState(value ? .error : defaultTextFieldState)
    }
    
    private func updateUI(for state: TextFieldState) {
        setupLineColor(with: state.lineColor(theme: theme))
        placeholderColor = state.placeholderColor(theme: theme)
        switch state {
        case .idle:
            hidePlaceholderIfNeeded(false)
            disableIconsIfNeeded(false)
        case .active:
            hidePlaceholderIfNeeded(true)
            disableIconsIfNeeded(false)
        case .error:
            hidePlaceholderIfNeeded(text == nil ? true : false)
            disableIconsIfNeeded(false)
        case .disabled:
            text = nil
            hidePlaceholderIfNeeded(false)
            disableIconsIfNeeded(true)
        }
    }
    
    private func setupLineColor(with color: UIColor) {
        lineView.backgroundColor = color
    }

    private func hidePlaceholderIfNeeded(_ shouldHide: Bool) {
        if shouldHide {
//            self.leftViewMode = .never
            self.attributedPlaceholder = nil
        } else {
            if text == nil || text?.isEmpty ?? true {
//                self.leftViewMode = .unlessEditing
                setupPlaceholder()
            }
        }
    }
    
    private func disableIconsIfNeeded(_ shouldDisable: Bool) {
        guard let leftStackView = leftView as? UIStackView,
              let leftUIImageView = leftStackView.arrangedSubviews[1] as? UIImageView,
              let rightButton = rightView as? UIFareButton else {
            return
        }
        
        leftUIImageView.applyTintColor(shouldDisable ? theme.disabledPlaceholderColor : theme.idlePlaceholderColor)
        rightButton.isEnabled = !shouldDisable
    }
}

extension UalaTextField: UITextFieldDelegate {

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        setState(.active)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if self.text?.isEmpty ?? true {
            setState(.idle)
        }
    }
}

enum TextFieldState {
    case idle
    case active
    case error
    case disabled
    
    func lineColor(theme: TextFieldTheme) -> UIColor {
        switch self {
        case .idle:
            return theme.idleLineColor
        case .active:
            return theme.activeLineColor
        case .error:
            return theme.errorLineColor
        case .disabled:
            return theme.disabledLineColor
        }
    }
    
    func placeholderColor(theme: TextFieldTheme) -> UIColor {
        switch self {
        case .idle, .active, .error:
            return theme.idlePlaceholderColor
        case .disabled:
            return theme.disabledPlaceholderColor
        }
    }
}
