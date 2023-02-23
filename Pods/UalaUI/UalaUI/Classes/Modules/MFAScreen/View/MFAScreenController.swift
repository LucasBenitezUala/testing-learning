//
//  MFAScreenController.swift
//  UalaUI
//
//  Created by Rodrigo Torres on 20/05/2022.
//

import UIKit
import UalaCore
import MessageUI

class MFAScreenController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var pinCodeTextField: PinTextFieldView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var bottomStackConstraint: NSLayoutConstraint!
    @IBOutlet weak var ualaLoader: UalaLoader!
    
    private let dependencies: MFAScreenViewDependenciesType
    var presenterType: MFAScreenPresenterType?
    
    init(dependencies: MFAScreenViewDependenciesType,
         presenter: MFAScreenPresenterType) {
        self.dependencies = dependencies
        self.presenterType = presenter
        super.init(nibName: String(describing: MFAScreenController.self), bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenterType?.viewDidLoad()
    }
    
    private func configureUI() {
        titleLabel.text = dependencies.parameters.title
        titleLabel.customize(style: dependencies.constants.titleStyle)
        
        subtitleLabel.text = dependencies.parameters.subtitle
        subtitleLabel.customize(style: dependencies.constants.subtitlenStyle)
        
        bottomStackConstraint.setKeyboardShowObserver()
        
        configurePlaceholder()
        
        errorLabel.isHidden = true
        errorLabel.customize(style: dependencies.constants.errorLabelStyle)
        errorLabel.textAlignment = .center
        
        pinCodeTextField.delegate = self
        
        bottomLabel.text = dependencies.parameters.bottomLabel
        bottomLabel.customize(style: dependencies.constants.bottomLabelStyle)
        
        configureResendButton()
        configureBottomButton()
        configurePinNormal()
    }
    
    // MARK: Configure Placeholder
    
    private func configurePlaceholder() {
        guard let placeholder = dependencies.placeholder else {
            placeholderLabel.isHidden = true
            return
        }
        placeholderLabel.text = placeholder.placerHolderText
        placeholderLabel.customize(style: placeholder.placeHolderStyle)
    }
    
    // MARK: Configure Buttons
    
    private func configureResendButton() {
        guard let button = dependencies.buttons.resendButton else {
            resendButton.isHidden = true
            return
        }
        resendButton.setTitle(button.titleButton, for: .disabled)
        resendButton.addTarget(self, action: #selector(didTapResendButtonAction), for: .touchUpInside)
        presenterType?.initializeTimer()
    }
    
    private func configureBottomButton() {
        bottomButton.setTitle(dependencies.buttons.bottomButton.titleButton, for: .normal)
        bottomButton.customize(style: dependencies.buttons.bottomButton.buttonStyle)
        bottomButton.addTarget(self, action: #selector(didTapEmailButtonAction), for: .touchUpInside)
    }
    
    // MARK: Configure Pin
    
    private func configurePinNormal() {
        errorLabel.isHidden = true
        pinCodeTextField.boxColor = dependencies.pinCode.pinCodeColorBoxNormal
        pinCodeTextField.textColor = dependencies.pinCode.pinCodeTextColorNormal
        pinCodeTextField.boxBorderColor = dependencies.pinCode.pinCodeBorderColor
        pinCodeTextField.spacing = dependencies.pinCode.pinCodeSpacing
        pinCodeTextField.boxCornerRadius = dependencies.pinCode.pinCodeBorderRadiusBox
        pinCodeTextField.characterLimit = dependencies.pinCode.pinCodeTextLenght
        pinCodeTextField.boxBorderWidth = dependencies.pinCode.pinCodeBorderWidth
    }
    
    // MARK: Actions
    
    @objc private func didTapResendButtonAction() {
        presenterType?.didTapResendCodeAction()
    }
    
    @objc private func didTapEmailButtonAction() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([translate("FORGOT_KEY_EMAIL", from: .Common)])
            present(mail, animated: true)
        } else {
            showAlert(title: translate("ERROR_OPEN_MAIL_TITLE", from: .Common), message: translate("ERROR_OPEN_MAIL_DESCRIPTION", from: .Common))
        }
    }
}

extension MFAScreenController: MFAScreenControllerType {
    
    func showKeyboard() {
        pinCodeTextField.becomeFirstResponder()
    }
    
    func hideKeyboard() {
        pinCodeTextField.resignFirstResponder()
    }
    
    func showPinError(error: String) {
        self.showKeyboard()
        errorLabel.text = error
        errorLabel.isHidden = false
        pinCodeTextField.boxBorderColor = dependencies.pinCode.pinCodeTextColorError
        pinCodeTextField.resetTextFiels()
    }

    func showError(error: Error) {
        self.hideLoading()
        self.showKeyboard()
        self.showAlert(with: error)
        pinCodeTextField.resetTextFiels()
    }
    
    func showLoading() {
        showLoadingView()
    }
    
    func hideLoading() {
        hideLoadingView()
    }
    
    func toogleButtonResendCode(isEnabled: Bool) {
        guard let button = dependencies.buttons.resendButton else { return }
        resendButton.isUserInteractionEnabled = isEnabled
        
        if isEnabled {
            resendButton.setTitle(translate("RESEND_CODE_TITLE", from: .Common), for: .normal)
            resendButton.customize(style: button.buttonStyle)
        }
    }
    
    func updateTitleTimer(with value: String) {
        guard let button = dependencies.buttons.resendButton else { return }
        let titleTimer: String = "\(translate("RESEND_CODE_TIMER_TITLE", from: .Common)) \(value)"
        resendButton.setTitle(titleTimer, for: .normal)
        resendButton.customize(style: button.buttonStyle)
        resendButton.setTitleColor(UalaStyle.colors.grey50, for: .normal)
        resendButton.isUserInteractionEnabled = false
    }

    func resetTextFieldSettings() {
        configurePinNormal()
    }
}

extension MFAScreenController: PinTextFieldViewDelegate {
    
    func pinTextFieldViewDidChange(_ pinTextField: PinTextFieldView) {
        if pinTextField.text.count == pinCodeTextField.characterLimit {
            presenterType?.didPinCodeTextChanged(code: pinCodeTextField.text)
        }
    }
}

extension MFAScreenController: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dissmiss()
    }
}
