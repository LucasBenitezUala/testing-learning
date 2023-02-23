//
//  LocationFactory+Dependencies.swift
//  UalaUI
//
//  Created by Ualá on 11/11/21.
//

import UIKit
import UalaUtils
import Combine
import CoreLocation

public protocol LocationViewType: UIViewController {
    var locationPresenter: LocationPresenterType? { get set }
}

public protocol LocationPresenterType: AnyObject {
    var view: LocationViewType? { get set }
    var interactor: LocationInteractorType? { get set }
    var router: LocationRouterType? { get set }
    var components: CurrentValueSubject<[LocationComponents], Never> { get }
    var tracker: UIEventTrackerProtocol? {get set}
    
    func startLocation()
    func requestLocation()
    func getCurrentLocationStatus()
    func getLocationStatus()
    func showMessage(message: String)
    func setup()
    func onSuccessAuthStatus(status: CLAuthorizationStatus)
}

public protocol LocationInteractorType: AnyObject {
    func setup()
    func startLocation()
    func requestLocation()
    func getCurrentLocationStatus()
    func getLocationStatus()
    
    var presenter: LocationPresenterType? { get set }
    var dependencies: LocationInteractorDependenciesType { get }
    var components: CurrentValueSubject<[LocationComponents], Never> { get }
}

public protocol LocationRouterType: AnyObject {
    var presenter: LocationPresenterType? { get set }
    
    func onContinue()
}

public protocol LocationInteractorDependenciesType {
    
    var startLocationUseCase: StarLocalizationUseCaseType { get }
    var getLatestLocationUseCase: GetAuthorizationLocationStatusUseCaseType { get }
    var currentLocationStatusUseCase: GetAuthorizationLocationStatusUseCaseType { get }
    var requestLocationUseCase: RequestLocationUseCaseType { get }
}
