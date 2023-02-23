//
//  WebViewFactoryType.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 12/10/21.
//

import Foundation

public protocol WebViewFactoryType {
    func build() -> WebViewViewController
}

@available(*, deprecated, message: "Use WebViewFactoryAsync implementation instead")
public struct WebViewFactory: WebViewFactoryType {
    
    private let dependencies: WebViewInteractorDependenciesType
    private let router: WebViewRouterType
    private let error: WebShowMessageErrorType
    
    public init(dependencies: WebViewInteractorDependenciesType,
                router: WebViewRouterType,
                error: WebShowMessageErrorType) {
        self.dependencies = dependencies
        self.router = router
        self.error = error
    }
    
    public func build() -> WebViewViewController {
        let interactor: WebViewInteractorType = WebViewInteractor(dependencies: dependencies)
        let presenter: WebViewPresenterType = WebViewPresenter(interactor: interactor, router: router, error: error)
        let view: WebViewViewType = WebViewViewController(presenter: presenter)
        
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        
        guard let viewController = view as? WebViewViewController else {
            return WebViewViewController(presenter: presenter)
        }
        
        return viewController
    }
}

public struct WebViewFactoryAsync: WebViewFactoryType {
    
    private let dependencies: WebViewInteractorDependenciesKind
    private let router: WebViewRouterType
    private let error: WebShowMessageErrorType
    
    public init(dependencies: WebViewInteractorDependenciesKind,
                router: WebViewRouterType,
                error: WebShowMessageErrorType) {
        self.dependencies = dependencies
        self.router = router
        self.error = error
    }
    
    public func build() -> WebViewViewController {
        let interactor: WebViewInteractorType = WebViewInteractorAsync(dependencies: dependencies)
        let presenter: WebViewPresenterType = WebViewPresenter(interactor: interactor, router: router, error: error)
        let view: WebViewViewType = WebViewViewController(presenter: presenter)
        
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        
        guard let viewController = view as? WebViewViewController else {
            return WebViewViewController(presenter: presenter)
        }
        
        return viewController
    }
}
