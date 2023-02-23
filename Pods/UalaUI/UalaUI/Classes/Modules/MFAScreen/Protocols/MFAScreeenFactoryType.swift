//
//  MFAScreeenFactoryType.swift
//  UalaUI
//
//  Created by Rodrigo Torres on 20/05/2022.
//

import UIKit

public struct MFAScreenFactory: FeatureFactoryType {
    
    private let viewDependencies: MFAScreenViewDependenciesType
    private let presenter: MFAScreenPresenterType
    private let interactor: MFAScreenInteractorType
    private let router: MFAScreenRouterType
    private let ualaTimer: UalaTimerType?
    
    public init(viewDependecies: MFAScreenViewDependenciesType,
                presenter: MFAScreenPresenterType,
                interactor: MFAScreenInteractorType,
                router: MFAScreenRouterType,
                ualaTimer: UalaTimerType?) {
        self.viewDependencies = viewDependecies
        self.presenter = presenter
        self.interactor = interactor
        self.router = router
        self.ualaTimer = ualaTimer
    }
    
    public func build() -> UIViewController {
        let viewController: MFAScreenControllerType = MFAScreenController(dependencies: viewDependencies, presenter: presenter)
        presenter.router = router
        presenter.viewcontroller = viewController
        presenter.interactor = interactor
        presenter.ualaTimer = ualaTimer
        interactor.presenter = presenter
        router.view = viewController
        
        return viewController
    }
}
