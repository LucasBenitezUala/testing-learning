//
//  Themeable+EXT.swift
//  UalaDSDemo
//
//  Created by Luis Perez on 29/06/22.
//

import UIKit

extension ThemeObserver where Self: UIViewController {
    public func observeThemeUpdates() {
        NotificationCenter.default.addObserver(forName: MainThemeManager.themeUpdateNotificationName,
                                               object: nil,
                                               queue: .main) { [weak self] _ in
            self?.updateTheme()
        }
    }
}
