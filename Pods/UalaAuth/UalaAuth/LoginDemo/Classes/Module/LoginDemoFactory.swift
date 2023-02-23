//
//  
//  LoginFactory.swift
//  UalaAuth
//
//  Created by Andrés Abraham Bonilla Gómex on 19/10/21.
//  Copyright © 2021 Ualá. All rights reserved.
//
//

import Foundation
import UIKit
import UalaCore

public struct LoginDemoFactory {
    
    private let presenterEvents: LoginDemoPresenterEventsType
    private let router: LoginDemoRouterType
    
    public init(presenterEvents: LoginDemoPresenterEventsType,
                router: LoginDemoRouterType) {
        self.presenterEvents = presenterEvents
        self.router = router
    }
    
    public func build() -> UIViewController {
        
        let dependencies: LoginDemoInteractorDependenciesType = LoginDemoInteractorDependencies()
        let interactor: LoginDemoInteractorType = LoginDemoInteractor(dependencies: dependencies)
        var presenter: LoginDemoPresenterType = LoginDemoPresenter(interactor: interactor,
                                                                   presenterEvents: presenterEvents,
                                                                   router: router)
        let view: LoginDemoViewType = LoginDemoViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
