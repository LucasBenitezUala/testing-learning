//
//  DynamicInformationCellTheme.swift
//  UalaFareUI
//
//  Created by Luis Perez on 27/07/22.
//

public protocol UIFareCellTheme {
    var leftTitleColor: UIColor { get }
    var leftSubtitleColor: UIColor { get }
    var rightTitleColor: UIColor { get }
    var rightSubtitleColor: UIColor { get }
    var seccondarySubtitleColor: UIColor { get }
    var bulletNumberColor: UIColor { get }
    var bulletBorderColor: UIColor { get }
    var separatorColor: UIColor { get }
    var iconTintColor: UIColor? { get }
    var titleTypographyStyle: TypographyStyle { get }
    var subtitleTypographyStyle: TypographyStyle { get }
    var buttonTypographyStyle: TypographyStyle { get }
    var buttonTextColor: UIColor { get }
    var bulletTypographyStyle: TypographyStyle { get }
    var seccondarySubtitleTypographyStyle: TypographyStyle { get }
    var actionButtonAlignment: UIStackView.Alignment { get }
    var iconAlignment: UIStackView.Alignment { get }
}
