//
//  
//  WebViewFactory+Dependencies.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 12/10/21.
//
//

import UIKit

public protocol WebViewViewType: UIViewController {
	var presenter: WebViewPresenterType? { get set }
    
    @MainActor func showURL(url: URL?)
}

public protocol WebViewPresenterType: AnyObject {
    var view: WebViewViewType? { get set }
    var interactor: WebViewInteractorType? { get set }
    var router: WebViewRouterType? { get set }
    
    @MainActor func showURL(url: URL?)
    func show(message: String)
}

public protocol WebViewInteractorType: AnyObject {
    func setup()
    
    var presenter: WebViewPresenterType? { get set }
}

public protocol WebViewRouterType: AnyObject {
    var view: WebViewViewType? { get set }
    
    func dismiss()
}

@available(*, deprecated, message: "Use WebViewInteractorDependenciesKind protocol instead")
public protocol WebViewInteractorDependenciesType {
    var getGetWebViewURL: GetWebViewURLUseCaseType { get }
}

public protocol WebViewInteractorDependenciesKind {
    var getGetWebViewURL: GetWebViewURLUseCaseKind { get }
}

public protocol WebShowMessageErrorType {
    var title: String { get }
    var titleButton: String { get }
}
