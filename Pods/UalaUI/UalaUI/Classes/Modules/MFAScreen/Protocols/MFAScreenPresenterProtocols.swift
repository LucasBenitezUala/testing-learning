//
//  MFAScreenPresenterProtocols.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 22/09/22.
//

public protocol MFAScreenPresenterType: AnyObject {
    var viewcontroller: MFAScreenControllerType? { get set }
    var interactor: MFAScreenInteractorType? { get set }
    var router: MFAScreenRouterType? { get set }
    var ualaTimer: UalaTimerType? { get set }
    
    func viewDidLoad()
    func didTapResendCodeAction()
    func didPinCodeTextChanged(code: String)
    func isCodeValid(isValid: Bool)
    func initializeTimer()
}

public extension MFAScreenPresenterType {

    func viewDidLoad() {
        // Empty default implementation
    }

    func didTapResendCodeAction() {
        // Empty default implementation
    }

    func didPinCodeTextChanged(code: String) {
        // Empty default implementation
    }

    func isCodeValid(isValid: Bool) {
        // Empty default implementation
    }

    func initializeTimer() {
        // Empty default implementation
    }
}
