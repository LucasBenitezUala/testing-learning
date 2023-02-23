//
//  UIFareCardModel.swift
//  UalaFareUI
//
//  Created by Luis Perez on 05/09/22.
//

public protocol UIFareCardModel {
    var titleTypographyStyle: TypographyStyle { get }
    var subtitleTypographyStyle: TypographyStyle { get }
    var scoreTypographyStyle: TypographyStyle { get }
    var type: UIFareCardType { get }
    var enabledConfiguration: UIFareCardModelConfiguration { get }
    var disabledConfiguration: UIFareCardModelConfiguration { get }
    var pressedConfiguration: UIFareCardModelConfiguration { get }
    var edgeInsets: UIEdgeInsets { get }
    var imageSize: CGSize { get }
    var imageCornerRadius: CGFloat { get }
    var generalSpacing: CGFloat { get }
    var spacingBetwenLabels: CGFloat { get }
    var orientation: NSLayoutConstraint.Axis { get }
    var textAlignment: UIStackView.Alignment { get }
    var showScore: Bool { get }
    var showHeaderImage: Bool { get }
    var showSubtitle: Bool { get }
    var iconImageContentMode: UIView.ContentMode { get }
    var cardWidth: CGFloat { get }
    var numberOfLinesForTitle: Int { get }
    var numberOfLinesForSubtitle: Int { get }
    var fixedSize: CGSize? { get }
}

struct DefaultUIFareCardModel: UIFareCardModel {
    var titleTypographyStyle: TypographyStyle
    var subtitleTypographyStyle: TypographyStyle
    var scoreTypographyStyle: TypographyStyle
    var type: UIFareCardType
    var enabledConfiguration: UIFareCardModelConfiguration
    var disabledConfiguration: UIFareCardModelConfiguration
    var pressedConfiguration: UIFareCardModelConfiguration
    var edgeInsets: UIEdgeInsets
    var imageSize: CGSize
    var imageCornerRadius: CGFloat
    var generalSpacing: CGFloat
    var spacingBetwenLabels: CGFloat
    var orientation: NSLayoutConstraint.Axis
    var textAlignment: UIStackView.Alignment
    var showScore: Bool
    var showHeaderImage: Bool
    var showSubtitle: Bool
    var iconImageContentMode: UIView.ContentMode
    var cardWidth: CGFloat
    var numberOfLinesForTitle: Int
    var numberOfLinesForSubtitle: Int
    var fixedSize: CGSize?
}
