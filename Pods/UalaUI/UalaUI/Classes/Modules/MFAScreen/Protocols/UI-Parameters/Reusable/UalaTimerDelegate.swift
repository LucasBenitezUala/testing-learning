//
//  UalaTimerDelegate.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 22/09/22.
//

public protocol UalaTimerDelegate: AnyObject {
    func updateTimer(timerTime: Int)
    func finishTimer()
}

public extension UalaTimerDelegate {

    func updateTimer(timerTime: Int) {
        // Empty default implementation
    }

    func finishTimer() {
        // Empty default implementation
    }
}
