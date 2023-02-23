//
//  ThemeObserver.swift
//  UalaDSDemo
//
//  Created by Luis Perez on 29/06/22.
//

import UIKit

public protocol ThemeObserver: AnyObject {
    func updateTheme()
    func observeThemeUpdates()
}
