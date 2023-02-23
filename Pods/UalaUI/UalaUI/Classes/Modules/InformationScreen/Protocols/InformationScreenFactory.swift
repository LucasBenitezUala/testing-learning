//
//  InformationScreenFactory.swift
//  Alamofire
//
//  Created by Rodrigo Torres on 17/05/2022.
//

import UIKit

public struct InformationScreenFactory: FeatureFactoryType {
    
    private let viewDependencies: InformationScreenDependenciesType
    private let presenter: InformationScreenPresenterType
    private let router: InformationScreenRouterType
    
    public init(viewDependencies: InformationScreenDependenciesType,
                presenter: InformationScreenPresenterType,
                router: InformationScreenRouterType) {
        self.viewDependencies = viewDependencies
        self.presenter = presenter
        self.router = router
    }
    
    public func build() -> UIViewController {
        
        let viewController: InformationScreenViewType = InformationScreenController(with: viewDependencies,
                                                                                    presenter: presenter)
        presenter.router = router
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
