//
//  ExampleViewController.swift
//  UalaAuth
//
//  Created by Rodrigo German Ferretty on 24/10/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import UalaCore
import UalaUtils

class LoginDemoViewController: UIViewController, PickerDelegate, LoginDemoViewType {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var schemeTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private let defaultTitle: String = "Login Demo"
    private let schemesSource: SchemesPicker
    private let countrySource: CountryPicker
    private var scheme: Scheme = .stage
    private var country: CountryEnvironment = .Argentina
    
    var presenter: LoginDemoPresenterType?
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(presenter: LoginDemoPresenterType) {
        self.presenter = presenter
        self.schemesSource = SchemesPicker()
        self.countrySource = CountryPicker()
        super.init(nibName: LoginDemoViewController.typeName, bundle: Bundle(for: type(of: self)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = defaultTitle
        schemesSource.delegate = self
        countrySource.delegate = self
        schemeTextField.inputView = schemesSource.picker
        schemeTextField.inputAccessoryView = schemesSource.button

        countryTextField.inputView = countrySource.picker
        countryTextField.inputAccessoryView = countrySource.button

        userNameTextField.accessibilityIdentifier = LoginDemoIdentifiers.loginDemoUserTextField
        passwordTextField.accessibilityIdentifier = LoginDemoIdentifiers.loginDemoPasswordTextField
        countryTextField.accessibilityIdentifier = LoginDemoIdentifiers.loginDemoCountryTextField
        schemeTextField.accessibilityIdentifier = LoginDemoIdentifiers.loginDemoSchemeTextField

        self.loadData()
    }
    
    func loadData() {
        guard let data = self.presenter?.fetchLoginData() else {
            return
        }
        userNameTextField.text = data.username
        passwordTextField.text = data.password
    }

    func selectedOption() {
        scheme = schemesSource.currentOption ?? scheme
        country = countrySource.currentOption ?? country
        
        schemeTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
        
        schemeTextField.text = scheme.rawValue
        countryTextField.text = country.rawValue
    }
        
    @IBAction func didClickLoginButton(_ sender: Any) {
        let username: String = userNameTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        
        let data: LoginData = LoginData(username: username, password: password)
        let parameters: LoginParameters = LoginParameters(loginData: data, scheme: scheme, country: country)
        presenter?.doLogin(params: parameters)
    }
}

extension LoginDemoViewController {
    
    func show(message: String) {
        showMessage(title: "Mensaje",
                    message: message,
                    titleButton: "Aceptar",
                    completion: { _ in
            // the button doesn't have action with the view, only the default
        })
    }
    
    func loading(_ value: Bool) {
        loginButton.isEnabled = !value
        if loginButton.isEnabled {
            hideLoading()
        } else {
            showLoading()
        }
    }

    func show(alert: UIAlertController) {
        present(alert, animated: true)
    }
}
