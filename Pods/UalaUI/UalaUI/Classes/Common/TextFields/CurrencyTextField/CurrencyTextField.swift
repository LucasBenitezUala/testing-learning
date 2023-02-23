//
//  CurrencyTextField.swift
//  UalaUI
//
//  Created by Mauro Distefano on 22/03/2022.
//

import Foundation
import UIKit

public class CurrencyTextField: UITextField {
    
    let lineView: UIView = UIView()
    let currencySymbolLabel: UILabel = UILabel()
    
    // Use this callback to grab the input amount as a currency-formatted string and as double.
    public var onAmountDidChange: ((String, Double) -> Void)?
    
    public var subLabel: UILabel = {
        let label = UILabel()
        label.customize(style: .regularFarePrimaryLeft(size: 12.0))
        label.numberOfLines = 0
        return label
    }()
    
    public var isError: Bool = false {
        didSet {
            updateState()
        }
    }
    
    public override var placeholder: String? {
        didSet {
            placeholderText = placeholder ?? ""
            updateAttributedPlaceholder()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            updateState()
        }
    }
    
    private var viewModel: CurrencyTextFieldViewModel = .fareCurrency()
    private var placeholderText: String = ""
    private var textInsets: UIEdgeInsets {
        guard let leftView = leftView else { return .zero }
        return UIEdgeInsets(top: 0.0, left: leftView.right + 8.0, bottom: 0.0, right: 0.0)
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeUI()
    }
    
    // MARK: - Public Methods
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    public func configure(withViewModel viewModel: CurrencyTextFieldViewModel) {
        self.viewModel = viewModel
        updateStyle()
    }
    
    // MARK: - Private methods
    
    private func customizeUI() {
        delegate = self
        contentVerticalAlignment = .top
        backgroundColor = .clear
        borderStyle = .none
        
        addTarget(self, action: #selector(firstResponderDidChange), for: .editingDidBegin)
        addTarget(self, action: #selector(firstResponderDidChange), for: .editingDidEnd)
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        keyboardType = .numberPad
        
        configureLineView()
        configureSubLabel()
        configureLeftView()
        updateStyle()
    }
    
    @objc private func firstResponderDidChange() {
        updateState()
    }
    
    @objc private func textDidChange() {
        guard let text = text else { return }
        
        let currencyAmount = text.currencyInputFormatting(minFractionDigits: viewModel.fractionDigits,
                                                          maxFractionDigits: viewModel.fractionDigits,
                                                          localeIdentifier: viewModel.localeIdentifier)
        
        self.text = currencyAmount.removeCurrency().removingWhitespaces()
        
        let doubleAmount = currencyAmount.convertCurrencyToDouble(localeIdentifier: viewModel.localeIdentifier)
        
        onAmountDidChange?(currencyAmount, doubleAmount)
    }
    
    private func configureLineView() {
        addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: lastBaselineAnchor, constant: 8.0 - (font?.descender ?? 0.0)),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1.0)
        ])
    }
    
    private func configureSubLabel() {
        addSubview(subLabel)
        
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 8.0),
            subLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureLeftView() {
        let leftIconView = UIView()
        leftIconView.addSubview(currencySymbolLabel)
        
        currencySymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencySymbolLabel.topAnchor.constraint(equalTo: leftIconView.topAnchor),
            currencySymbolLabel.leadingAnchor.constraint(equalTo: leftIconView.leadingAnchor),
            currencySymbolLabel.trailingAnchor.constraint(equalTo: leftIconView.trailingAnchor)
        ])
        
        leftView = leftIconView
        leftViewMode = .always
    }
    
    private func updateStyle() {
        font = viewModel.font
        textAlignment = viewModel.textAlignment
        
        currencySymbolLabel.font = viewModel.font
        currencySymbolLabel.text = viewModel.currencySymbol
        
        placeholderText = String.strCurrency(from: 0, viewModel.fractionDigits).removeCurrency()
        
        updateState()
    }
    
    private func updateState() {
        subLabel.isHidden = !isEnabled
        updateAttributedPlaceholder()
        
        guard isEnabled else {
            updateWithColor(viewModel.secondaryColor)
            return
        }
        
        if isError {
            updateWithColor(viewModel.errorColor)
        } else {
            tintColor = viewModel.mainColor
            textColor = viewModel.mainColor
            subLabel.textColor = viewModel.mainColor
            lineView.backgroundColor = isFirstResponder ? viewModel.focusedColor : viewModel.secondaryColor
            currencySymbolLabel.textColor = {
                if isFirstResponder {
                    return viewModel.focusedColor
                } else if text.isEmpty {
                    return viewModel.placeholderColor
                } else {
                    return viewModel.mainColor
                }
            }()
        }
    }
    
    private func updateWithColor(_ color: UIColor) {
        textColor = color
        tintColor = color
        currencySymbolLabel.textColor = color
        lineView.backgroundColor = color
        subLabel.textColor = color
    }
    
    private func updateAttributedPlaceholder() {
        guard !isFirstResponder, !isError, isEnabled else {
            attributedPlaceholder = nil
            return
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                   attributes: [.foregroundColor: viewModel.placeholderColor, .font: viewModel.font])
    }
}

// MARK: - UITextFieldDelegate
extension CurrencyTextField: UITextFieldDelegate {
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        // To set cursor always to the end and avoid strange behaviors
        let endPosition: UITextPosition = textField.endOfDocument
        textField.selectedTextRange = textField.textRange(from: endPosition, to: endPosition)
    }
}
