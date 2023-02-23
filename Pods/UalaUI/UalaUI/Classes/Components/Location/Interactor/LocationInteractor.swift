//
//  LocationInteractor.swift
//  UalaUI
//
//  Created by Ualá on 11/11/21.
//

import UIKit
import Combine
import UalaUtils
import CoreLocation

class LocationInteractor: LocationInteractorType {
    
    var presenter: LocationPresenterType?
    internal let dependencies: LocationInteractorDependenciesType
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    internal var components: CurrentValueSubject<[LocationComponents], Never> = CurrentValueSubject<[LocationComponents], Never>([])
    
    init(dependencies: LocationInteractorDependenciesType) {
        self.dependencies = dependencies
    }
}

// MARK: - Interactor - Public Methods (Through Type)
extension LocationInteractor {
    
    func setup() {
        components.send(LocationComponents.allCases)
    }
    
    func startLocation() {
        dependencies.startLocationUseCase.execute(type: .always)
            .sink { [weak self] error in
                switch error {
                case .failure(let error):
                    self?.presenter?.showMessage(message: error.localizedDescription)
                case .finished:
                    LogManager.shared.debug(info: "finish")
                }
            } receiveValue: { _ in }.store(in: &cancellable)
    }
    
    func getCurrentLocationStatus() {
        dependencies.getLatestLocationUseCase.execute()
            .sink { [weak self] error in
                switch error {
                case .failure(let error):
                    self?.presenter?.showMessage(message: error.localizedDescription)
                case .finished:
                    LogManager.shared.debug(info: "finish")
                }
            } receiveValue: { [weak self] status in
                self?.presenter?.onSuccessAuthStatus(status: status)
            }.store(in: &cancellable)
    }
    
    func getLocationStatus() {
        dependencies.currentLocationStatusUseCase.execute()
            .sink { [weak self] error in
                switch error {
                case .failure(let error):
                    self?.presenter?.showMessage(message: error.localizedDescription)
                case .finished:
                    LogManager.shared.debug(info: "finish")
                }
            } receiveValue: { [weak self] status in
                self?.presenter?.onSuccessAuthStatus(status: status)
            }.store(in: &cancellable)
    }
    
    func requestLocation() {
        dependencies.requestLocationUseCase.execute()
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] error in
                switch error {
                case .failure(let error):
                    self?.presenter?.showMessage(message: error.localizedDescription)
                case .finished:
                    LogManager.shared.debug(info: "finish")
                }
            } receiveValue: { _ in }.store(in: &cancellable)
    }
}
