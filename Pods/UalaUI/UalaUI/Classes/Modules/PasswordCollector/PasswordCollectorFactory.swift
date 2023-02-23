//
//  PasswordCollectorFactory.swift
//  UalaUI
//
//  Created by Agustina Ardisana on 31/10/2022.
//

public struct PasswordCollectorFactory: FeatureFactoryType {
    
    private let dependencies: PasswordCollectorViewDependenciesType
    private var presenter: PasswordCollectorPresenterType
    private let interactor: PasswordCollectorInteractorType
    private var router: PasswordCollectorRouterType
    
    public init(dependencies: PasswordCollectorViewDependenciesType,
                presenter: PasswordCollectorPresenterType,
                interactor: PasswordCollectorInteractorType,
                router: PasswordCollectorRouterType) {
        self.dependencies = dependencies
        self.presenter = presenter
        self.interactor = interactor
        self.router = router
    }

    public func build() -> UIViewController {
        let viewController = PasswordCollectorViewController(dependencies: dependencies,
                                                             presenter: presenter)
        presenter.view = viewController
        presenter.interactor = interactor

        router.view = viewController
        
        return viewController
    }
}
