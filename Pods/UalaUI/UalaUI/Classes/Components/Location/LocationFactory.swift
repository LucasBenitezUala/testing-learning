//
//  LocationFactory.swift
//  UalaUI
//
//  Created by Ualá on 11/11/21.
//

import Foundation
import UIKit
import UalaUtils

public struct LocationFactory {
    
    public static func build(router: LocationRouterType) -> UIViewController {
        
        let interactor: LocationInteractorType = LocationInteractorFactory.build()
        let router: LocationRouterType = router
        let presenter: LocationPresenterType = LocationPresenter(interactor: interactor, router: router)
        let view: LocationViewType = LocationViewController(presenter: presenter)
        let tracker: UIEventTracker = UIEventTracker()
        
        presenter.view = view
        presenter.tracker = tracker
        interactor.presenter = presenter
        router.presenter = presenter
        
        guard let viewController = view as? LocationViewController else {
            return LocationViewController(presenter: presenter)
        }
        
        return viewController
    }
    
    //    For initialization with custom text
    public static func build(router: LocationRouterType, withTitle title: String?, subtitle: String?, buttonText: String?) -> UIViewController {
        
        let interactor: LocationInteractorType = LocationInteractorFactory.build()
        let router: LocationRouterType = router
        let presenter: LocationPresenterType = LocationPresenter(interactor: interactor, router: router)
        let view: LocationViewType = LocationViewController(presenter: presenter, withTitle: title, subtitle: subtitle, buttonText: buttonText)
        let tracker: UIEventTracker = UIEventTracker()
        
        presenter.view = view
        presenter.tracker = tracker
        interactor.presenter = presenter
        router.presenter = presenter
        
        guard let viewController = view as? LocationViewController else {
            return LocationViewController(presenter: presenter)
        }
        
        return viewController
    }
}

struct LocationInteractorFactory {
    
    static func build() -> LocationInteractorType {
        
        let locationService: LocationServiceType = LocationService.shared
        
        let getLocationStatusUseCase: GetAuthorizationLocationStatusUseCaseType = GetAuthorizationLocationStatusUseCase(
            locationService: locationService
        )
        
        let getCurrentLocationDelegate: GetAuthorizationLocationStatusUseCaseType = GetLocationDelegateUseCase(locationService: locationService)
        
        let requestLocationUseCase: RequestLocationUseCaseType = RequestLocationUseCase(
            locationService: locationService,
            getAuthorizationLocationStatusUsecase: getLocationStatusUseCase
        )
        
        let startLocationUseCase: StarLocalizationUseCaseType = StarLocalizationUseCase(
            locationService: locationService,
            getAuthorizationLocationStatusUsecase: getLocationStatusUseCase,
            requestLocationUseCase: requestLocationUseCase
        )
        
        let depenendencies: LocationInteractorDependenciesType = LocationInteractorDependencies(
            startLocationUseCase: startLocationUseCase,
            getLatestLocationUseCase: getCurrentLocationDelegate,
            currentLocationStatusUseCase: getLocationStatusUseCase,
            requestLocationUseCase: requestLocationUseCase
        )
        
        let locationInteractor: LocationInteractorType = LocationInteractor(dependencies: depenendencies)
        return locationInteractor
    }
}

struct LocationInteractorDependencies: LocationInteractorDependenciesType {
    
    let startLocationUseCase: StarLocalizationUseCaseType
    let getLatestLocationUseCase: GetAuthorizationLocationStatusUseCaseType
    let currentLocationStatusUseCase: GetAuthorizationLocationStatusUseCaseType
    let requestLocationUseCase: RequestLocationUseCaseType
    
    init(
         startLocationUseCase: StarLocalizationUseCaseType,
         getLatestLocationUseCase: GetAuthorizationLocationStatusUseCaseType,
         currentLocationStatusUseCase: GetAuthorizationLocationStatusUseCaseType,
         requestLocationUseCase: RequestLocationUseCaseType) {
        self.startLocationUseCase = startLocationUseCase
        self.getLatestLocationUseCase = getLatestLocationUseCase
        self.currentLocationStatusUseCase = currentLocationStatusUseCase
        self.requestLocationUseCase = requestLocationUseCase
    }
}
