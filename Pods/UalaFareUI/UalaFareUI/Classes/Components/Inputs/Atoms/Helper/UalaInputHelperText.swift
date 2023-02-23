//
//  UalaInputHelperText.swift
//  Pods-UalaFareUI_Example
//
//  Created by Matías Schwalb on 18/07/2022.
//

import UIKit

public final class UalaInputHelperText: UIView {
    
    private var helperLabel: UILabel!
    private var helperIcon: UIImageView!
    private var stackView: UIStackView!
    private var separatorView: UIView!
    
    private var text: String?
    
    private var theme: InputHelperTheme
    private var helperType: InputHelperType {
        didSet {
            updateUI(for: helperType)
        }
    }
    
    public var isEnabled: Bool = true {
        didSet {
            updateUI(for: isEnabled ? helperType : .disabled)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(theme: InputHelperTheme, type: InputHelperType) {
        self.theme = theme
        self.helperType = type
        super.init(frame: .zero)
        setupUI()
    }
    
    private func setupUI() {
        stackView = UIStackView()
        self.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        
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
        helperIcon = UIImageView()
        helperIcon.widthAnchor.constraint(equalToConstant: 14).isActive = true
        helperIcon.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        
        helperLabel = UILabel()
        helperLabel.applyTypography(theme.helperLabelTypography)
        
        [helperIcon, separatorView, helperLabel].forEach { item in
            if let item = item {
                self.addSubview(item)
                stackView.addArrangedSubview(item)
            }
        }
    }
    
    func setType(_ type: InputHelperType, text: String? = nil) {
        self.helperType = type
        helperLabel.text = text
    }
    
    private func updateUI(for type: InputHelperType) {
        switch type {
        case .information:
            configureUI(with: theme.informationConfiguration)
        case .success:
            configureUI(with: theme.successConfiguration)
        case .warning:
            configureUI(with: theme.warningConfiguration)
        case .error:
            configureUI(with: theme.errorConfiguration)
        case .standard:
            configureUI(with: theme.standardConfiguration)
        case .disabled:
            configureUI(with: theme.disabledConfiguration)
        }
    }
    
    private func configureUI(with configuration: InputHelperConfiguration) {
        helperLabel.textColor = configuration.tint
        if let icon = configuration.icon {
            helperIcon.isHidden = false
            separatorView.isHidden = false
            helperIcon.image = icon
            helperIcon.applyTintColor(configuration.tint)
        } else {
            helperIcon.isHidden = true
            separatorView.isHidden = true
        }
    }
    
    public func setTheme(_ theme: InputHelperTheme) {
        self.theme = theme
    }
}

public enum InputHelperType {
    case information
    case success
    case warning
    case error
    case standard
    case disabled
}
