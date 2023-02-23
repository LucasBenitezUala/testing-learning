//
//  
//  WebViewInteractor.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 12/10/21.
//
//

import UIKit

class WebViewInteractor: WebViewInteractorType {
    
    var presenter: WebViewPresenterType?
    private let dependencies: WebViewInteractorDependenciesType
    
    init(dependencies: WebViewInteractorDependenciesType) {
        self.dependencies = dependencies
    }
}

// MARK: - Interactor - Public Methods (Through Type)
extension WebViewInteractor {
    
    func setup() {
        dependencies.getGetWebViewURL.execute()
            .done {[weak presenter] (url: URL?) in
                Task.detached { [weak presenter] in
                    await presenter?.showURL(url: url)
                }
            }.catch { [weak self] (error: Error) in
                self?.presenter?.show(message: error.localizedDescription)
            }
    }
}

class WebViewInteractorAsync: WebViewInteractorType {

    var presenter: WebViewPresenterType?
    private let dependencies: WebViewInteractorDependenciesKind
    
    public init(dependencies: WebViewInteractorDependenciesKind) {
        self.dependencies = dependencies
    }
    
    func setup() {
        Task.detached {
            do {
                let url = try await self.dependencies.getGetWebViewURL.execute()
                await self.presenter?.showURL(url: url)
            } catch {
                self.presenter?.show(message: error.localizedDescription)
            }
        }
    }
}
