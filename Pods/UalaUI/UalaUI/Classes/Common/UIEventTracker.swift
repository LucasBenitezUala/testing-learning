//
//  TransferencesEventTracker.swift
//  Uala
//
//  Created by Aldana Rastrelli on 23/10/2021.
//

import Foundation
import UalaCore

public protocol UIEventTrackerProtocol: AnyObject {
    func trackLocationHasBeenEnabled()
}

class UIEventTracker: UIEventTrackerProtocol {

    private let tracker: UalaCore.Analytics
    private let screen = "Location"
        
    init(tracker: UalaCore.Analytics = ServiceLocator.inject()) {
        self.tracker = tracker
    }
    
    func trackLocationHasBeenEnabled() {
        tracker.trackEvent(Event(name: UITrackingEvent.locationHasBeenEnabled.rawValue, type: nil, id: nil, screen: nil))
    }
}

enum UITrackingEvent: String {
    case locationHasBeenEnabled = "transferencia_selecciona_conceder_permiso"
}

enum UITrackingProperty: String {
//    This might be completed later
    case example = "ejemplo_propiedad"
}
