//
//  TagTheme.swift
//  UalaFareUI
//
//  Created by Luis Perez on 19/07/22.
//

public protocol UIFareTagModel {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
    var typographyStyle: TypographyStyle { get }
    var cornerRadius: CGFloat { get }
    var edgeInsets: UIEdgeInsets { get }
}
