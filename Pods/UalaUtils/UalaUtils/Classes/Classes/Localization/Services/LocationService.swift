//
//  LocationService.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 21/10/21.
//

import CoreLocation
import Combine

public protocol LocationServiceType {
    func askLocationPermits(type: RequestTypeLocation) -> AnyPublisher<Void, Error>
    func requestLocation() -> AnyPublisher<Void, Error>
    func authorizationStatus() -> AnyPublisher<CLAuthorizationStatus, Error>
    func getErrorLocation() -> AnyPublisher<Error, Never>
    
    var currentLocation: PassthroughSubject<CLLocation, Error> { get }
    var currentAuthStatus: PassthroughSubject<CLAuthorizationStatus, Never> { get }
}

public class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceType {
    
    private let locationManager: CLLocationManager = CLLocationManager()
    private var error: Error = LocationError.unknown
    public var currentLocation: PassthroughSubject<CLLocation, Error> = PassthroughSubject<CLLocation, Error>()
    public var currentAuthStatus: PassthroughSubject<CLAuthorizationStatus, Never> = PassthroughSubject<CLAuthorizationStatus, Never>()
    
    public static let shared: LocationService = LocationService()
    
    private override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else {
            currentLocation.genericError()
            return
        }
        
        validateLocation(location: firstLocation)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.error = error
    }
    
    public func authorizationStatus() -> AnyPublisher<CLAuthorizationStatus, Error> {
        let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        return Just(status)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    public func askLocationPermits(type: RequestTypeLocation) -> AnyPublisher<Void, Error> {
        return .create { [weak self] (observer) -> Disposable in
            guard let self = self else {
                observer.onNext(())
                observer.onComplete()
                return Disposable()
            }
            switch type {
            case .always:
                self.locationManager.requestAlwaysAuthorization()
            case .whenInUse:
                self.locationManager.requestWhenInUseAuthorization()
            }
            
            observer.onNext(())
            observer.onComplete()
            return Disposable()
        }
    }
    
    public func requestLocation() -> AnyPublisher<Void, Error> {
        
        return .create { [weak self] (observer) -> Disposable in
            guard let self = self else {
                observer.onNext(())
                observer.onComplete()
                return Disposable()
            }
            
            self.locationManager.requestLocation()
            
            observer.onNext(())
            observer.onComplete()
            return Disposable()
        }
    }
    
    public func getErrorLocation() -> AnyPublisher<Error, Never> {
        return Just(self.error)
            .eraseToAnyPublisher()
    }
    
    private func validateLocation(location: CLLocation) {
        let maxAge: TimeInterval = 60
        let requiredAccuracy: CLLocationAccuracy = 100
        
        let date: Date = Date()
        let isExactLocationValid = date.timeIntervalSince(location.timestamp) < maxAge && location.horizontalAccuracy <= requiredAccuracy
        var locationIsValid: Bool
                    
        if #available(iOS 14.0, *) {
            switch locationManager.accuracyAuthorization {
            case .reducedAccuracy:
                locationIsValid = true
            default:
                locationIsValid = isExactLocationValid
            }
        } else {
            locationIsValid = isExactLocationValid
        }
        
        if locationIsValid {
            currentLocation.send(location)
        } else {
            self.locationManager.requestLocation()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
        currentAuthStatus.send(status)
    }
}
