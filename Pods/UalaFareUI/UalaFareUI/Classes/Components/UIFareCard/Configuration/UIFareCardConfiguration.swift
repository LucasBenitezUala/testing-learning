//
//  UIFareCardConfiguration.swift
//  UalaFareUI
//
//  Created by Luis Perez on 06/09/22.
//

public protocol UIFareCardModelConfiguration {
    var iconTintColor: UIColor? { get }
    var backgroundColor: UIColor { get }
    var shadow: Shadows? { get }
    var imageOpacity: CGFloat { get }
    var titleColor: UIColor { get }
    var subtitleColor: UIColor { get }
    var ratingColor: UIColor { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
}
