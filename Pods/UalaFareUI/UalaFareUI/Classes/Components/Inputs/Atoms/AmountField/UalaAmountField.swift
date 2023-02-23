//
//  UalaAmountField.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 03/08/2022.
//

import UIKit

public class UalaAmountField: UITextField {
    
    // MARK: - Properties
    private var titleLabel: UILabel?
    private var lineView: UIView!
    private var currencyLabel: UILabel!
    
    private var theme: AmountFieldTheme
    
    private var amountFieldState: AmountFieldState {
        didSet {
            updateUI(for: amountFieldState)
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            setState(isEnabled ? .empty : .disabled)
        }
    }
    
    init(theme: AmountFieldTheme, initialState: AmountFieldState = .empty) {
        self.theme = theme
        amountFieldState = initialState
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        borderStyle = .none
        delegate = self
        
        self.applyTypography(theme.fieldType.typography)
        self.textColor = theme.idleTextColor
        
        textAlignment = theme.fieldType.alignment
        
        lineView = UIView()
        lineView.backgroundColor = theme.activeLineColor
        self.addSubview(lineView)
        
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        setupConstraints()
        setupSideView()
        setupKeyboardType()
        
        setFormattedText("0")
        setState(amountFieldState)
    }
    
    private func setupConstraints() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8)
        ])
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: theme.fieldType.size)
        ])
    }
    
    private func setupSideView() {
        self.leftViewMode = .always
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        self.addSubview(stackView)
        
        let label = UILabel()
        label.applyTypography(theme.fieldType.typography)
        label.text = theme.currencySymbol
        label.tintColor = theme.currencyActiveColor
        currencyLabel = label
        self.addSubview(currencyLabel)
        
        let leftPadding = UIView()
        leftPadding.backgroundColor = .clear
        leftPadding.widthAnchor.constraint(equalToConstant: 8).isActive = true
        
        let rightPadding = UIView()
        rightPadding.backgroundColor = .clear
        rightPadding.widthAnchor.constraint(equalToConstant: 8).isActive = true
        
        [leftPadding, label, rightPadding].forEach { item in
            stackView.addSubview(item)
            stackView.addArrangedSubview(item)
        }
        
        self.leftView = stackView
        
        let rightView = UIView()
        rightView.backgroundColor = .clear
        rightView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        
        self.rightView = rightView
        self.rightViewMode = .always
    }
    
    private func setupKeyboardType() {
        self.keyboardType = .decimalPad
    }
    
    private func setState(_ amountFieldState: AmountFieldState) {
        self.amountFieldState = amountFieldState
    }
    
    private func updateUI(for state: AmountFieldState) {
        switch state {
        case .empty:
            self.textColor = theme.idleTextColor
            currencyLabel.textColor = theme.currencyIdleColor
            lineView.backgroundColor = theme.idleLineColor
        case .filled:
            self.textColor = theme.activeTextColor
            currencyLabel.textColor = theme.currencyActiveColor
            lineView.backgroundColor = theme.idleLineColor
        case .active:
            self.textColor = theme.activeTextColor
            currencyLabel.textColor = theme.currencyActiveColor
            lineView.backgroundColor = theme.activeLineColor
        case .error:
            self.textColor = theme.activeTextColor
            currencyLabel.textColor = theme.currencyErrorColor
            lineView.backgroundColor = theme.errorLineColor
        case .disabled:
            self.textColor = theme.disabledPlaceholderColor
            currencyLabel.textColor = theme.currencyDisabledColor
            lineView.backgroundColor = theme.disabledLineColor
        }
    }
    
    @objc private func textDidChange() {
        guard let text = text else { return }
        
        setFormattedText(text)
    }
    
    private func setFormattedText(_ text: String) {
        let currencyAmount = text.currencyInputFormatting(minFractionDigits: 2,
                                                          maxFractionDigits: 2,
                                                          currencySymbol: theme.currencySymbol,
                                                          localeIdentifier: theme.currencyLocaleIdentifier)
        
        self.text = currencyAmount.removeCurrency(symbol: theme.currencySymbol).removingWhitespaces()
    }
    
    public func setError(_ isError: Bool) {
        if isError {
            setState(.error)
        } else {
            setState(.active)
        }
    }
}

extension UalaAmountField: UITextFieldDelegate {
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        setState(.active)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        setState(.active)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if text?.isEmpty ?? true || text == "0" {
            setState(.empty)
        } else {
            setState(.filled)
        }
    }
}

public enum AmountFieldState {
    case empty
    case filled
    case active
    case error
    case disabled
}
