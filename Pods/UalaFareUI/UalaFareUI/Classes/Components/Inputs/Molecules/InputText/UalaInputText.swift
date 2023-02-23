//
//  UalaInputText.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 20/07/2022.
//

import UIKit

public final class UalaInputText: UIView {
    
    private var stackView: UIStackView?
    private var titleLabel: UILabel?
    private var textField: UalaTextField!
    private var separatorView: UIView!
    private var helperText: UalaInputHelperText!
    private var defaultHelperType: InputHelperType?
    private var defaultHelperText: String?
    
    private var theme: InputTextTheme? {
        didSet {
            guard let theme = theme, let textField = textField, let helperText = helperText else {
                return
            }

            textField.setTheme(theme.textFieldTheme)
            helperText.setTheme(theme.helperTheme)
        }
    }
    
    public var isEnabled: Bool = true {
        didSet {
            textField.isEnabled = isEnabled
            helperText.isEnabled = isEnabled
            titleLabel?.textColor = isEnabled ? theme?.title?.titleDefaultColor : theme?.title?.titleDisabledColor
        }
    }
    
    public init(theme: InputTextTheme) {
        self.theme = theme
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public func setTheme(_ theme: InputTextTheme) {
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
        
        guard let stackView = stackView else {
            return
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func addItemsToStackView() {
        guard let theme = theme, stackView?.arrangedSubviews.isEmpty ?? true else {
            return
        }
        
        var titleLabelStack: UIStackView? = nil
        if let title = theme.title {
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
        
        textField = UalaTextField(theme: theme.textFieldTheme, initialState: .idle)
        
        separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        helperText = UalaInputHelperText(theme: theme.helperTheme, type: theme.helperType ?? .standard)
        self.defaultHelperType = theme.helperType
        self.defaultHelperText = theme.helperText
        setInputHelper(theme.helperType, text: theme.helperText)
        let helperPadding = UIView()
        helperPadding.backgroundColor = .clear
        helperPadding.widthAnchor.constraint(equalToConstant: 8).isActive = true
        let helperStack = UIStackView(arrangedSubviews: [helperPadding, helperText])
        helperStack.axis = .horizontal
        
        [titleLabelStack, textField, separatorView, helperStack].compactMap { $0 }.forEach { item in
            self.addSubview(item)
            stackView?.addArrangedSubview(item)
        }
    }
    
    public func setInputHelper(_ type: InputHelperType?, text: String?) {
        guard let type = type else {
            return
        }

        helperText.setType(type, text: text)
    }
    
    public func setError(_ value: Bool, text: String? = nil) {
        titleLabel?.textColor = value ? theme?.title?.titleErrorColor : theme?.title?.titleDefaultColor
        setInputHelper(value ? .error : defaultHelperType, text: value ? text ?? defaultHelperText : defaultHelperText)
        textField.setError(value)
    }
}
