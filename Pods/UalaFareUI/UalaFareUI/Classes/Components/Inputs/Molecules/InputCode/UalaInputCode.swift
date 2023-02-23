//
//  UalaInputCode.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 22/08/2022.
//

import UIKit

public final class UalaInputCode: UIView {
    
    private var stackView: UIStackView!
    private var codeField: UalaCodeField!
    private var separatorView: UIView!
    private var helper: UalaInputHelperText!
    private var defaultHelperType: InputHelperType?
    private var defaultHelperText: String?
    
    private var theme: InputCodeTheme?
    
    public var isEnabled: Bool = true {
        didSet {
            codeField.isEnabled = isEnabled
            helper.isEnabled = isEnabled
        }
    }
    
    public var value: String {
        return codeField.value
    }
    
    public init(theme: InputCodeTheme) {
        self.theme = theme
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public func setTheme(_ theme: InputCodeTheme) {
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

        let codeField = UalaCodeField(theme: theme.codeFieldTheme)
        self.codeField = codeField
        
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        separatorView.backgroundColor = .clear
        self.separatorView = separatorView
        
        let helper = UalaInputHelperText(theme: theme.helperTheme, type: theme.helperType ?? .standard)
        self.helper = helper
        self.defaultHelperType = theme.helperType
        self.defaultHelperText = theme.helperText
        setInputHelper(theme.helperType, text: theme.helperText)
        
        [codeField, separatorView, helper].forEach { item in
            self.addSubview(item)
            stackView?.addArrangedSubview(item)
        }
    }
    
    public func setInputHelper(_ type: InputHelperType?, text: String?) {
        guard let type = type else {
            return
        }
        
        if type != .error {
            self.defaultHelperType = type
        }
        
        self.helper.setType(type, text: text)
    }
    
    public func setError(_ value: Bool, text: String?) {
        setInputHelper(value ? .error : defaultHelperType, text: value ? text ?? defaultHelperText : defaultHelperText)
        codeField.setError(value)
    }
}
