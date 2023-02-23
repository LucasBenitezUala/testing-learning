//
//  UIViewController.swift
//  Uala
//
//  Created by Nelson Domínguez on 21/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import UalaCore
import UIKit

public protocol FeatureFactoryType {
    func build() -> UIViewController
}

public enum AlertConfirmResult {
    case cancel, accept
}

public protocol BaseView: AnyObject, BaseAlertView, BaseKeyboardDismissable, BaseLoadingView, BaseViewNavigation {
    var currentNavigationController: UINavigationController? { get }
}

public protocol BaseViewNavigation {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func dissmiss(completion: (() -> Void)?)
    func popViewController()
    func popViewController(_ animated: Bool, completion: @escaping (() -> Void))
    func popToRootView()
    func popToRootView(_ animated: Bool, completion: @escaping (() -> Void))
    func push(view: UIViewController)
}

public protocol BaseKeyboardDismissable {
    func dismissKeyboard()
}

public protocol BaseLoadingView {
    func showLoadingView()
    func hideLoadingView()
    func showLottieLoadingView(viewModel: LottieLoadingViewViewModelType)
    func hideLottieLoadingView(duration: TimeInterval, completion: (() -> Void)?)
    func hideLottieLoadingView()
}

public protocol BaseAlertView {
    func showConfirm(title: String, message: String, completion: @escaping (AlertConfirmResult) -> Void)
    func showConfirm(title: String, message: String, cancelTitle: String, acceptTitle: String, completion: @escaping (AlertConfirmResult) -> Void)
    func showAlert(with error: Error)
    func showAlert(title: String, message: String)
    func showAlert(title: String, message: String, action: UIAlertAction)
    func showAlert(title: String, message: String, actions: [UIAlertAction])
    func showAlert(title: String, message: String, actions: [UIAlertAction], actionIDs: [String])
    func share(item: Any)
    func showAlertSheet(title: String?, message: String?, actionTitles: [String?], actions: [((UIAlertAction) -> Void)?], tintColor: UIColor?, isCancel: Bool?)
}

extension BaseView {
    
    public func hideLottieLoadingView() {
        hideLottieLoadingView(duration: 0.2, completion: nil)
    }
}

extension UIViewController: BaseView {
    
    private struct AssociatedKey {
        static var lottieLoader = "lottieLoader"
    }
    
    private var lottieLoaderViewController: LottieLoadingViewController? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.lottieLoader) as? LottieLoadingViewController
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.lottieLoader, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public var currentNavigationController: UINavigationController? {
        if let navigationController = self.navigationController {
            return navigationController
        } else if let nav = self.presentedViewController as? UINavigationController {
            return nav
        } else {
            return nil
        }
    }
    
    public func getTopParent() -> UIViewController {
        guard let parent = self.parent else {
            return self
        }
        
        var topParent: UIViewController = parent
        while let top = topParent.parent {
            topParent = top
        }
        
        return topParent
    }
    
    @objc open func showLoadingView() {
        guard presentedViewController != nil else {
            UalaLoader.sharedLoader.show()
            return
        }
    }
    
    @objc open func hideLoadingView() {
        UalaLoader.sharedLoader.hide()
    }
    
    public func showLottieLoadingView(viewModel: LottieLoadingViewViewModelType) {
        guard lottieLoaderViewController == nil else {
            return
        }
        
        let loadingViewController = LottieLoadingViewController(viewModel: viewModel)
        lottieLoaderViewController = loadingViewController
        let containerViewController = getTopParent()
 
        containerViewController.addChild(loadingViewController)
        containerViewController.view.addSubview(loadingViewController.view)
        loadingViewController.view.anchor(top: containerViewController.view.topAnchor,
                                          leading: containerViewController.view.leadingAnchor,
                                          bottom: containerViewController.view.bottomAnchor,
                                          trailling: containerViewController.view.trailingAnchor)
        loadingViewController.didMove(toParent: containerViewController)
        loadingViewController.lottieView.play()
    }
    
    public func hideLottieLoadingView(duration: TimeInterval, completion: (() -> Void)?) {
        guard let loadingViewController = lottieLoaderViewController else {
            return
        }
    
        loadingViewController.willMove(toParent: nil)
        loadingViewController.removeFromParent()
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            loadingViewController.view.alpha = 0
        }, completion: { [weak self] _ in
            loadingViewController.view.removeFromSuperview()
            self?.lottieLoaderViewController = nil
            completion?()
        })
    }
    
    @objc public func dismissKeyboard() {
        guard let currentFirstResponder = view.currentFirstResponder() else { return }
        currentFirstResponder.resignFirstResponder()
    }
    
    private func handleError(error: Error) -> Error {
        if let ualaError = error as? UalaAppError {
            return ualaError.ualaError
        } else {
            return error
        }
    }
    
    public func showAlert(with error: Error) {
        let error = handleError(error: error)
        showAlert(title: translate("Error"), message: error.localizedDescription)
    }
    
    public func showAlert(title: String, message: String) {
        let alertViewController = UIAlertController(title: translate(title), message: translate(message), preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: translate("Cerrar"), style: .default, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
    
    public func showAlert(title: String, message: String, action: UIAlertAction) {
        let alertViewController = UIAlertController(title: translate(title), message: translate(message), preferredStyle: .alert)
        alertViewController.addAction(action)
        present(alertViewController, animated: true, completion: nil)
    }
    
    public func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alertViewController = UIAlertController(title: translate(title), message: translate(message), preferredStyle: .alert)
        for action in actions {
            alertViewController.addAction(action)
        }
        present(alertViewController, animated: true, completion: nil)
    }
    
    public func showAlert(title: String, message: String, actions: [UIAlertAction], actionIDs: [String]) {
        let alertViewController = UIAlertController(title: translate(title), message: translate(message), preferredStyle: .alert)
        for (index, action) in actions.enumerated() {
            action.setAccessibilityIdentifier(accessabilityIdentifier: actionIDs[index])
            alertViewController.addAction(action)
        }
        present(alertViewController, animated: true) {
            alertViewController.applyAccessibilityIdentifiers()
        }
    }
    
    public func showConfirm(title: String, message: String, completion: @escaping (AlertConfirmResult) -> Void) {
        showConfirm(title: title, message: message, cancelTitle: "Cancelar", acceptTitle: "Aceptar", completion: completion)
    }
    
    public func showConfirm(title: String, message: String, cancelTitle: String, acceptTitle: String, completion: @escaping (AlertConfirmResult) -> Void) {
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: translate(cancelTitle), style: .default, handler: { _ in
            completion(.cancel)
        }))
        alertViewController.addAction(UIAlertAction(title: translate(acceptTitle), style: .default, handler: { _ in
            completion(.accept)
        }))
        
        present(alertViewController, animated: true, completion: nil)
    }
    
    public func showAlertSheet(title: String?,
                               message: String?,
                               actionTitles: [String?],
                               actions: [((UIAlertAction) -> Void)?],
                               tintColor: UIColor?,
                               isCancel: Bool?) {
        
        var alert = UIAlertController()
        if title.isEmpty || message.isEmpty {
            alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        } else {
            alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        }
        
        alert.view.tintColor = tintColor ??  UalaStyle.colors.cornflower
        
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        
        if isCancel ?? false {
            let cancelOption = UIAlertAction(title: translate("Cancelar"), style: .cancel)
            alert.addAction(cancelOption)
        }
        present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func alertControllerBackgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func tapToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    public func share(item: Any) {
        let itemToShare = [item]
        let activityViewController = UIActivityViewController(activityItems: itemToShare, applicationActivities: [])
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc public func dissmiss(completion: (() -> Void)? = nil) {
        self.dismiss(animated: true, completion: completion)
    }
    
    @objc open func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    open func popViewController(_ animated: Bool, completion: @escaping (() -> Void)) {
        self.navigationController?.popViewController(animated, completion: completion)
    }
    
    public func popToRootView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    public func popToRootView(_ animated: Bool, completion: @escaping (() -> Void)) {
        self.navigationController?.popToRootViewController(animated, completion: completion)
    }
    
    public func push(view: UIViewController) {
        self.navigationController?.pushViewController(view, animated: true)
    }
}

// MARK: - UIAlert Accessibility Identifier
extension UIAlertController {
    func applyAccessibilityIdentifiers() {
        for action in actions {
            let label = action.value(forKey: "__representer")
            let view = label as? UIView
            view?.accessibilityIdentifier = action.getAcAccessibilityIdentifier()
        }
    }
}

extension UIAlertAction {
    private struct AssociatedKeys {
        static var AccessabilityIdentifier = "nsh_AccesabilityIdentifier"
    }

    func setAccessibilityIdentifier(accessabilityIdentifier: String) {
        objc_setAssociatedObject(self, &AssociatedKeys.AccessabilityIdentifier, accessabilityIdentifier, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }

    func getAcAccessibilityIdentifier() -> String? {
        return objc_getAssociatedObject(self, &AssociatedKeys.AccessabilityIdentifier) as? String
    }
}
