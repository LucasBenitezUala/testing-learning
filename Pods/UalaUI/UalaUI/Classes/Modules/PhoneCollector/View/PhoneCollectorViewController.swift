//
//  PhoneCollectorViewController.swift
//  UalaAuth
//
//  Created by Agustin Jaimes on 11/05/22.
//

import Foundation
import UIKit
import UalaUI

final internal class PhoneCollectorViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descritionLabel: UILabel!
    @IBOutlet weak var prefixTextField: BancarTextField!
    @IBOutlet weak var phoneTextField: NumericTextField!
    @IBOutlet weak var primaryAction: UIButton!
    @IBOutlet weak var botomButtonConstraint: NSLayoutConstraint!
    
    private let dependencies: PhoneCollectorViewDependenciesType
    private let presenter: PhoneCollectorPresenterType
    
    init(dependencies: PhoneCollectorViewDependenciesType,
         presenter: PhoneCollectorPresenterType) {
        self.dependencies = dependencies
        self.presenter = presenter
        super.init(nibName: String(describing: PhoneCollectorViewController.self),
                   bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter.viewDidLoad()
    }
    
    private func configureUI() {
        titleLabel.text = dependencies.parameters.title
        descritionLabel.text = dependencies.parameters.description
        
        prefixTextField.placeholderText = dependencies.parameters.prefixPlaceholder
        prefixTextField.text = dependencies.parameters.prefixTitle
        prefixTextField.isUserInteractionEnabled = false /* V2 will remove this */
        
        phoneTextField.placeholderText = dependencies.parameters.phonePlaceholder
        phoneTextField.subLabel.text = dependencies.parameters.underlinePlaceholder
        phoneTextField.subLabel.customize(style: .regular(size: dependencies.uiConstants.sublabelSize,
                                                          color: .warmGreyFive))
        
        configureTextFields()
        
        primaryAction.setTitle(dependencies.parameters.primaryActionTitle, for: .normal)
        primaryAction.isEnabled = false
        primaryAction.customize(style: UalaStyle.buttons.standardFilledLight)
        botomButtonConstraint.setKeyboardShowObserver()
    }
    
    @IBAction func didTapPrimaryButton(_ sender: Any) {
        presenter.didTapPrimaryAction()
    }
    
    @IBAction func valueChanged(_ sender: BancarTextField) {
        guard let value = sender.text else { return }
        presenter.didCollectPhone(value: value)
    }
    
    private func configureTextFields() {
        /* v2 will enchance this */
        let textfields = [prefixTextField, phoneTextField]
        textfields
            .compactMap { $0 }
            .forEach { [weak self] textfield in
                guard let self = self else { return }
                textfield.leftInset = self.dependencies.uiConstants.textFieldLeftInset
                textfield.customize(style: .fareText)
                textfield.configure()
                textfield.keyboardType = .phonePad
                textfield.autocapitalizationType = .none
                textfield.autocorrectionType = .no
                textfield.borderStyle = .none
                textfield.subLabel.isHidden = false
            }
    }
}

extension PhoneCollectorViewController: PhoneCollectorViewType {
    
    func setError(_ value: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let message: String = value ? self.dependencies.parameters.underlineErrorDescription : self.dependencies.parameters.underlinePlaceholder
            self.phoneTextField.setError(isError: value, text: message)
            self.primaryAction.isEnabled = !value
            self.presenter.didUpdateError()
        }
    }
}
