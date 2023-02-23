//
//  UserActionManager.swift
//  UalaCore
//
//  Created by Ualá on 16/08/2022.
//

final public class UserActionManager {

    static public func executeAction(view: UserActionView, action: UserAction, customAction: (() -> Void)? = nil) {
        switch action.type {
        case .alert:
            showAlert(with: action, view: view)
        case .deepLink:
            launchDeepLink()
        case .url:
            open(url: action.link ?? "")
        case .custom:
            customAction?()
        default:
            return
        }
    }
    
    private static func showAlert(with action: UserAction, view: UserActionView) {
        let actions = action.buttons.compactMap { button in
            UIAlertAction(title: button.title, style: .default) { _ in
                if let buttonAction = button.userAction {
                    executeAction(view: view, action: buttonAction)
                }
            }
        }

        view.showAlertView(message: action.message ?? "", actions: actions)
    }
    
    private static func launchDeepLink() {}
    
    private static func open(url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url: url)
        }
    }
}

public protocol UserActionView: UIViewController {
    func showAlertView(message: String, actions: [UIAlertAction])
}
