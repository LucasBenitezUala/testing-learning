//
//  UalaTimer.swift
//  UalaUI
//
//  Created by Rodrigo Torres on 26/05/2022.
//

import Foundation

public protocol UalaTimerType: AnyObject {
    var timer: Timer { get }
    var timeOut: Int { get set }
    var timeIn: Int { get set }
    var delegate: UalaTimerDelegate? { get set }
    
    func startTimer()
    func stopTimer()
    func timerFired()
}

public extension UalaTimerType {

    func startTimer() {
        // Empty default implementation
    }

    func stopTimer() {
        // Empty default implementation
    }

    func timerFired() {
        // Empty default implementation
    }
}
