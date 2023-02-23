//
//  UalaCodeField.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 16/08/2022.
//

public protocol UalaCodeFieldDelegate {
    func codeFieldDidChange(_ codeField: UalaCodeField)
}

public class UalaCodeField: UIView {
    
    private var stackView: UIStackView!
    private var textFields: [UITextField] = []
    private var currentTextFieldEditingPosition = 0

    private var delegate: UalaCodeFieldDelegate?
    private var theme: CodeFieldTheme?
    
    public var value: String {
        let stringsDictionary = textFields.map { (textField) -> String in
            return textField.text ?? ""
        }
        return stringsDictionary.joined()
    }
    
    public var isEnabled: Bool = true {
        didSet {
            textFields.forEach { textfield in
                textfield.isEnabled = isEnabled
                updateTextField(textfield, state: isEnabled ? .idle : .disabled)
            }
        }
    }
    
    init(theme: CodeFieldTheme) {
        self.theme = theme
        super.init(frame: .zero)
        setupUI()
    }
    
    public func setTheme(_ theme: CodeFieldTheme) {
        self.theme = theme
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        guard theme != nil else { return }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
        
        let stackView = UIStackView()
        self.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = Spacings.spacing2.value

        self.stackView = stackView
        setStackViewConstraints()
        removeAllTextField()
        createCharacterFields()
    }
    
    private func setStackViewConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    private func createCharacterFields() {
        guard let theme = theme else {
            return
        }

        for _ in 0..<theme.length {
            let textfield = CharacterField()
            textfield.deleteBackwardDelegate = self
            textfield.delegate = self
            textfield.translatesAutoresizingMaskIntoConstraints = false
            textfield.widthAnchor.constraint(equalToConstant: 40).isActive = true
            textfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
            customizeTextField(textField: textfield)
            stackView.addArrangedSubview(textfield)
            self.textFields.append(textfield)
        }
    }
    
    func removeAllTextField() {
        stackView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        self.textFields = []
    }
    
    private func customizeTextField(textField: UITextField) {
        guard let theme = theme else {
            return
        }

        textField.isUserInteractionEnabled = false
        textField.textAlignment = .center
        textField.applyBorder(width: .borderWidthThin, color: nil)
        textField.applyCornerRadius(.radiiMd)
        textField.applyTypography(theme.typography)
        textField.isSecureTextEntry = theme.isSecureText
        textField.keyboardType = theme.keyboardType
        updateTextField(textField, state: .idle)
    }
    
    func updateTextField(_ textField: UITextField, state: CharacterFieldState) {
        guard let theme = theme else {
            return
        }

        switch state {
        case .idle:
            textField.layer.borderColor = theme.idleBorderColor.cgColor
            textField.layer.backgroundColor = theme.defaultFillColor.cgColor
        case .active:
            textField.layer.borderColor = theme.activeBorderColor.cgColor
            textField.layer.backgroundColor = theme.defaultFillColor.cgColor
        case .error:
            textField.layer.borderColor = theme.errorBorderColor.cgColor
            textField.layer.backgroundColor = theme.defaultFillColor.cgColor
        case .disabled:
            textField.layer.borderColor = theme.idleBorderColor.cgColor
            textField.layer.backgroundColor = theme.disabledFillColor.cgColor
        }
    }
    
    private func decreasePosition() {
        guard self.currentTextFieldEditingPosition > 0 else { return }
        self.currentTextFieldEditingPosition -= 1
    }
    
    private func incrementPosition() {
        self.currentTextFieldEditingPosition += 1
    }
    
    private func setActiveTextField() {
        if self.currentTextFieldEditingPosition < self.textFields.count {
            let textField = self.textFields[self.currentTextFieldEditingPosition]
            textField.isUserInteractionEnabled = true
            textField.becomeFirstResponder()
        } else {
            if self.currentTextFieldEditingPosition == self.textFields.count {
                self.decreasePosition()
                let textField = self.textFields[self.currentTextFieldEditingPosition]
                textField.resignFirstResponder()
                textFields.forEach { myTextfield in
                    updateTextField(myTextfield, state: .idle)
                }
            }
        }
    }
    
    private func sendTextToNextTextfield(text: String) {
        self.textFields[self.currentTextFieldEditingPosition].text = text
    }
    
    private func resetTextFiels() {
        textFields.forEach({ $0.text = "" })
        currentTextFieldEditingPosition = 0
        setActiveTextField()
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer?) {
        let editTextField =  self.textFields[self.currentTextFieldEditingPosition]
        editTextField.isUserInteractionEnabled = true
        editTextField.becomeFirstResponder()
    }
    
    public func setError(_ value: Bool) {
        let state: CharacterFieldState
        if value {
            state = .error
        } else {
            if self.value.isEmpty {
                state = .idle
            } else {
                state = .active
            }
        }
        
        textFields.forEach { textfield in
            updateTextField(textfield, state: state)
        }
    }
}

extension UalaCodeField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty {
            textField.text = string
            updateTextField(textField, state: .idle)
            self.decreasePosition()
            self.setActiveTextField()
        } else {
            updateTextField(textField, state: .active)
            self.incrementPosition()
            self.setActiveTextField()
            if textField.text?.isEmpty ?? false {
                textField.text = string
            } else {
                self.sendTextToNextTextfield(text: string)
            }
        }
        
        self.delegate?.codeFieldDidChange(self)
        
        return false
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.isUserInteractionEnabled = false
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}

extension UalaCodeField: CharacterFieldDeleteBackwardDelegate {
    func deleteBackwardInEmptyField(textField: UITextField) {
        self.decreasePosition()
        self.setActiveTextField()
    }
}

enum CharacterFieldState {
    case idle
    case active
    case error
    case disabled
}
