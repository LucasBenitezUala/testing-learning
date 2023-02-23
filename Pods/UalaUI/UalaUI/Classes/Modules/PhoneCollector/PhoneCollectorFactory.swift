//
//  PhoneCollectorFactory.swift
//  UalaUI
//
//  Created by Andrés Abraham Bonilla Gómex on 17/05/22.
//

import Foundation

public struct PhoneCollectorFactory: FeatureFactoryType {
    
    private let viewControllerDependencies: PhoneCollectorViewDependenciesType
    private let presenter: PhoneCollectorPresenterType
    private let interactor: PhoneCollectorInteractorType?
    private let router: PhoneCollectorRouterType
    private let lenghtPhone: Int
    
    public init(viewControllerDependencies: PhoneCollectorViewDependenciesType,
                presenter: PhoneCollectorPresenterType,
                router: PhoneCollectorRouterType,
                interactor: PhoneCollectorInteractorType,
                lenghtPhone: Int = 10) {
        self.viewControllerDependencies = viewControllerDependencies
        self.presenter = presenter
        self.router = router
        self.interactor = interactor
        self.lenghtPhone = lenghtPhone
    }
    
    public func build() -> UIViewController {
        
        let viewController = PhoneCollectorViewController(dependencies: viewControllerDependencies,
                                                          presenter: presenter)

        presenter.lenghtPhone = lenghtPhone
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController
        
        return viewController
    }
}
