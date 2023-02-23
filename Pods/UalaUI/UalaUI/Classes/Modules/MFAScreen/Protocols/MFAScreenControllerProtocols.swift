//
//  MFAScreenControllerProtocols.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 22/09/22.
//

public protocol MFAScreenControllerType: UIViewController {
    func showKeyboard()
    func hideKeyboard()
    func showPinError(error: String)
    func showError(error: Error)
    func showLoading()
    func hideLoading()
    func toogleButtonResendCode(isEnabled: Bool)
    func updateTitleTimer(with value: String)
    func resetTextFieldSettings()
}

public extension MFAScreenControllerType {

    func showKeyboard() {
        // Empty default implementation
    }

    func hideKeyboard() {
        // Empty default implementation
    }

    func showPinError(error: String) {
        // Empty default implementation
    }

    func showError(error: Error) {
        // Empty default implementation
    }

    func showLoading() {
        // Empty default implementation
    }

    func hideLoading() {
        // Empty default implementation
    }

    func toogleButtonResendCode(isEnabled: Bool) {
        // Empty default implementation
    }

    func updateTitleTimer(with value: String) {
        // Empty default implementation
    }

    func resetTextFieldSettings() {
        // Empty default implementation
    }
}
