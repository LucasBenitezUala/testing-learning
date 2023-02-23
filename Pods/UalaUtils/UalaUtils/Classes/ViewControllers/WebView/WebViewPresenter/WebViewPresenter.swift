//
//  
//  WebViewPresenter.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 12/10/21.
//
//

import UIKit

class WebViewPresenter: WebViewPresenterType {
    
    weak  var view: WebViewViewType?
    var interactor: WebViewInteractorType?
    var router: WebViewRouterType?
    var error: WebShowMessageErrorType
    
    init(interactor: WebViewInteractorType,
         router: WebViewRouterType,
         error: WebShowMessageErrorType) {
        self.router = router
        self.interactor = interactor
        self.error = error
    }
}

extension WebViewPresenter {
    
    @MainActor
    func showURL(url: URL?) {
        view?.showURL(url: url)
    }
    
    func show(message: String) {
        view?.showMessage(title: error.title,
                          message: message,
                          titleButton: error.titleButton,
                          completion: { [weak self] _ in
            self?.router?.dismiss()
        })
    }
}
