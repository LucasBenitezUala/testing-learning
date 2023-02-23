//
//  NavigationBarAppearance.swift
//  UalaFareUI
//
//  Created by Luis Perez on 11/10/22.
//

import UIKit

public protocol NavigationBarAppearance {
    var backgroundColor: UIColor { get }
    var iconTintColor: UIColor { get }
    var titleTextColor: UIColor { get }
    var titleTyphography: TypographyStyle { get }
}

internal struct DefaultHomeNavigationBarAppearance: NavigationBarAppearance {
    var backgroundColor: UIColor
    var iconTintColor: UIColor
    var titleTextColor: UIColor
    var titleTyphography: TypographyStyle
}
