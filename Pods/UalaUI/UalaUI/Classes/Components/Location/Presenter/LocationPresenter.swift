//
//  LocationPresenter.swift
//  UalaUI
//
//  Created by Ualá on 11/11/21.
//

import UIKit
import UalaCore
import Combine
import CoreLocation

class LocationPresenter: LocationPresenterType {
    
    weak var view: LocationViewType?
    var interactor: LocationInteractorType?
    var router: LocationRouterType?
    var components: CurrentValueSubject<[LocationComponents], Never> = CurrentValueSubject<[LocationComponents], Never>([])
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    internal var tracker: UIEventTrackerProtocol?
    
    init(interactor: LocationInteractorType, router: LocationRouterType) {
        self.router = router
        self.interactor = interactor
    }
}

extension LocationPresenter {
    
    func setup() {
        interactor?.setup()
        guard let interactor = interactor else {
            return
        }
        components.send(interactor.components.value)
    }
    
    func startLocation() {
        interactor?.startLocation()
    }
    
    func requestLocation() {
        interactor?.requestLocation()
    }
    
    /// This method works as a listener if the status of the permissions changes.
    func getCurrentLocationStatus() {
        interactor?.getCurrentLocationStatus()
    }
    
    /// This method works to get the current location of the user.
    func getLocationStatus() {
        tracker?.trackLocationHasBeenEnabled()
        interactor?.getLocationStatus()
    }
    
    func onSuccessAuthStatus(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            router?.onContinue()
        case .notDetermined:
            startLocation()
        default:
            showAlertGoToSettings()
        }
    }
    
    func showMessage(message: String) {
        view?.showAlert(with: message)
    }
    
    private func showAlertGoToSettings() {
        let action: UIAlertAction = UIAlertAction(title: translate("REQUEST_LOCATION_ALERT_BUTTON", from: .Common), style: .default) { _ in
            if let bundleId = Bundle.main.bundleIdentifier,
                let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        view?.showAlert(
            title: translate("REQUEST_LOCATION_ALERT_TITLE", from: .Common),
            message: translate("REQUEST_LOCATION_ALERT_MESSAGE", from: .Common),
            action: action
        )
    }
}
