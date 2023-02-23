//
//  InformationListRouter.swift
//  Alamofire
//
//  Created by Mario García on 21/10/21.
//

import Foundation

final class InformationListRouter {
    
    private var baseController: BaseViewController?
    private var navigation: UINavigationController? {
        if let nav = baseController?.presentedViewController as? UINavigationController {
            return nav
        } else if let nav = baseController?.navigationController {
            return nav
        } else {
            return baseController as? UINavigationController
        }
    }
    private let isPresent: Bool
    
    init(baseController: BaseViewController, isPresent: Bool) {
        self.baseController = baseController
        self.isPresent = isPresent
    }
}

extension InformationListRouter: InformationListRouterPresenterInterface {
    func show(presenter: InformationListPresenterViewInterface) {
        let viewController = InformationListViewController(presenter: presenter)
        viewController.hidesBottomBarWhenPushed = true
        
        if isPresent {
            navigation?.present(viewController, animated: true)
        } else {
            navigation?.pushViewController(viewController, animated: true)
        }
    }
    
    func popBack() {
        if isPresent {
            navigation?.dismiss(animated: true)
        } else {
            navigation?.popViewController(animated: true)
        }
    }
    
    func performAction(action: InformationViewAction?) {
        guard let view = baseController else { return }
        action?.actionButtonPressed(view: view)
    }
}
