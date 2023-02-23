//
//  PasswordCollectorViewController.swift
//  UalaUI
//
//  Created by Agustina Ardisana on 31/10/2022.
//

import UIKit

final internal class PasswordCollectorViewController: UIViewController {
    
    private let dependencies: PasswordCollectorViewDependenciesType
    private let presenter: PasswordCollectorPresenterType
    
    var titleLbl: UILabel = UILabel()
    var descriptionLbl: UILabel = UILabel()
    var primaryAction: UIButton = UIButton()
    var passwordTextField: BancarTextField = BancarTextField()
    var showPasswordBtn: UIButton = UIButton()

    var spacing: CGFloat = 24
    var horizontalInsets: CGFloat = CGFloat()
    
    init(dependencies: PasswordCollectorViewDependenciesType,
         presenter: PasswordCollectorPresenterType) {
        self.dependencies = dependencies
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupCell(with: dependencies.parameters)
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
        horizontalInsets = dependencies.uiConstants.horizontalInsets
        configureTopSection()
        configureMiddleSection()
        configureBottomSection()
    }
    
    private func configureTopSection() {
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.customize(style: .blackTitle)
        view.addSubview(titleLbl)
        
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.customize(style: .regularBlackLeft(size: 14))
        descriptionLbl.numberOfLines = 0
        view.addSubview(descriptionLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,
                                              constant: horizontalInsets),
            descriptionLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor,
                                                constant: spacing),
            descriptionLbl.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,
                                                    constant: horizontalInsets),
            descriptionLbl.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,
                                                     constant: horizontalInsets)
        ])
    }
    
    private func configureMiddleSection() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.customize(style: .fareText)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.leftInset = .zero
        passwordTextField.addTarget(self,
                                    action: #selector(onTextfieldChanged),
                                    for: .editingChanged)
        view.addSubview(passwordTextField)
        
        showPasswordBtn.translatesAutoresizingMaskIntoConstraints = false
        showPasswordBtn.setImage(CommonImage(named: "default_show_password"), for: .normal)
        showPasswordBtn.isHidden = true
        passwordTextField.rightView = showPasswordBtn
        passwordTextField.rightViewMode = .whileEditing
        showPasswordBtn.addTarget(self,
                                  action: #selector(toggleShowPasswordBtn),
                                  for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor,
                                                   constant: spacing),
            passwordTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,
                                                       constant: horizontalInsets),
            passwordTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,
                                                        constant: -horizontalInsets),
            passwordTextField.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func configureBottomSection() {
        primaryAction.translatesAutoresizingMaskIntoConstraints = false
        primaryAction.customize(style: UalaStyle.buttons.standardFilledLight)
        primaryAction.isEnabled = false
        primaryAction.addTarget(self, action: #selector(didTapPrimaryAction), for: .touchUpInside)
        view.addSubview(primaryAction)
        
        NSLayoutConstraint.activate([
            primaryAction.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                                  constant: -spacing),
            primaryAction.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,
                                                   constant: horizontalInsets),
            primaryAction.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,
                                                    constant: -horizontalInsets),
            primaryAction.heightAnchor.constraint(equalToConstant: (spacing * 2))
        ])
    }
    
    func setupCell(with parameters: PasswordCollectorParametersType) {
        titleLbl.text = parameters.title
        descriptionLbl.text = parameters.description
        primaryAction.setTitle(parameters.primaryActionTitle, for: .normal)
        
        passwordTextField.placeholderText = parameters.placeholder
        passwordTextField.keyboardType = parameters.keyboardType
    }
    
    @objc func toggleShowPasswordBtn() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        
        let showIcon = CommonImage(named: "default_show_password")
        let hideIcon = CommonImage(named: "default_hide_password")
        showPasswordBtn.setImage(passwordTextField.isSecureTextEntry ? showIcon : hideIcon,
                                 for: .normal)
    }
    
    @objc func onTextfieldChanged() {
        showPasswordBtn.isHidden = passwordTextField.text.isEmpty
        primaryAction.isEnabled = !passwordTextField.text.isEmpty
    }
    
    @objc func didTapPrimaryAction() {
        if let value = passwordTextField.text {
            presenter.didCollectPassword(value: value)
        }
        presenter.didTapPrimaryAction()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
}

extension PasswordCollectorViewController: PasswordCollectorViewType {
    func setError(_ value: Bool) {
        primaryAction.isEnabled = !value
        let errorMessage: String = dependencies.parameters.underlineErrorDescription
        passwordTextField.setError(isError: value, text: errorMessage)
        presenter.didUpdateError()
    }
}
