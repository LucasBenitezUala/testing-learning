//
//  UalaInputAmount.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 03/08/2022.
//

import UIKit

public final class UalaInputAmount: UIView {
    
    private var stackView: UIStackView!
    private var titleLabel: UILabel?
    private var amountField: UalaAmountField!
    private var separatorView: UIView!
    private var helper: UalaInputHelperText!
    private var defaultHelperType: InputHelperType?
    private var defaultHelperText: String?
    
    private var theme: InputAmountTheme?
    
    public var isEnabled: Bool = true {
        didSet {
            amountField.isEnabled = isEnabled
            helper.isEnabled = isEnabled
            titleLabel?.textColor = isEnabled ? theme?.title?.titleDefaultColor : theme?.title?.titleDisabledColor
        }
    }
    
    init(theme: InputAmountTheme) {
        self.theme = theme
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public func setTheme(_ theme: InputAmountTheme) {
        self.theme = theme
        setupUI()
    }
    
    private func setupUI() {
        
        let stackView = UIStackView()
        self.addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill

        self.stackView = stackView
        
        setStackViewConstraints()
        addItemsToStackView()
    }
    
    private func setStackViewConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func addItemsToStackView() {
        guard let theme = theme else {
            return
        }
        
        var titleLabelStack: UIStackView?
        if let title = theme.title, theme.amountFieldTheme.fieldType == .currencyNumber { // Titles are only allowed for currency field type
            let titleLabel = UILabel()
            titleLabel.applyTypography(title.titleTypography)
            titleLabel.textColor = title.titleDefaultColor
            titleLabel.text = title.title
            self.titleLabel = titleLabel
            let titleLabelPadding = UIView()
            titleLabelPadding.backgroundColor = .clear
            titleLabelPadding.widthAnchor.constraint(equalToConstant: 8).isActive = true
            titleLabelStack = UIStackView(arrangedSubviews: [titleLabelPadding, titleLabel])
            titleLabelStack?.axis = .horizontal
        }

        let amountField = UalaAmountField(theme: theme.amountFieldTheme)
        self.amountField = amountField
        
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        separatorView.backgroundColor = .clear
        self.separatorView = separatorView
        
        let helper = UalaInputHelperText(theme: theme.helperTheme, type: theme.helperType ?? .standard)
        self.helper = helper
        self.defaultHelperType = theme.helperType
        self.defaultHelperText = theme.helperText
        setInputHelper(theme.helperType, text: theme.helperText)
        let helperPadding = UIView()
        helperPadding.backgroundColor = .clear
        helperPadding.widthAnchor.constraint(equalToConstant: 8).isActive = true
        let helperStack = UIStackView(arrangedSubviews: [helperPadding, helper])
        helperStack.axis = .horizontal
        
        [titleLabelStack, amountField, separatorView, helperStack].compactMap { $0 }.forEach { item in
            self.addSubview(item)
            stackView?.addArrangedSubview(item)
        }
    }
    
    public func setInputHelper(_ type: InputHelperType?, text: String?) {
        guard let type = type else {
            return
        }

        self.helper.setType(type, text: text)
    }
    
    public func setError(_ value: Bool, text: String? = nil) {
        titleLabel?.textColor = value ? theme?.title?.titleErrorColor : theme?.title?.titleDefaultColor
        setInputHelper(value ? .error : defaultHelperType, text: value ? text ?? defaultHelperText : defaultHelperText)
        amountField.setError(value)
    }
}
