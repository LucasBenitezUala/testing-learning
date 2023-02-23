//
//  DefaultDynamicInformationCellTheme.swift
//  UalaFareUI
//
//  Created by Luis Perez on 27/07/22.
//

import UIKit

struct DefaultDynamicCellTheme: UIFareCellTheme {
    var leftTitleColor: UIColor
    var leftSubtitleColor: UIColor
    var rightTitleColor: UIColor
    var rightSubtitleColor: UIColor
    var seccondarySubtitleColor: UIColor
    var bulletNumberColor: UIColor
    var bulletBorderColor: UIColor
    var separatorColor: UIColor
    var iconTintColor: UIColor?
    var titleTypographyStyle: TypographyStyle
    var subtitleTypographyStyle: TypographyStyle
    var buttonTypographyStyle: TypographyStyle
    var buttonTextColor: UIColor
    var bulletTypographyStyle: TypographyStyle
    var seccondarySubtitleTypographyStyle: TypographyStyle
    var actionButtonAlignment: UIStackView.Alignment
    var iconAlignment: UIStackView.Alignment
    
    init(leftTitleColor: UIColor,
         leftSubtitleColor: UIColor,
         rightTitleColor: UIColor,
         rightSubtitleColor: UIColor,
         seccondarySubtitleColor: UIColor,
         bulletNumberColor: UIColor,
         bulletBorderColor: UIColor,
         separatorColor: UIColor,
         iconTintColor: UIColor?,
         titleTypographyStyle: TypographyStyle,
         subtitleTypographyStyle: TypographyStyle,
         buttonTypographyStyle: TypographyStyle,
         buttonTextColor: UIColor,
         bulletTypographyStyle: TypographyStyle,
         seccondarySubtitleTypographyStyle: TypographyStyle,
         actionButtonAlignment: UIStackView.Alignment,
         iconAlignment: UIStackView.Alignment) {
        self.leftTitleColor = leftTitleColor
        self.leftSubtitleColor = leftSubtitleColor
        self.rightTitleColor = rightTitleColor
        self.rightSubtitleColor = rightSubtitleColor
        self.seccondarySubtitleColor = seccondarySubtitleColor
        self.bulletNumberColor = bulletNumberColor
        self.bulletBorderColor = bulletBorderColor
        self.separatorColor = separatorColor
        self.iconTintColor = iconTintColor
        self.titleTypographyStyle = titleTypographyStyle
        self.subtitleTypographyStyle = subtitleTypographyStyle
        self.buttonTypographyStyle = buttonTypographyStyle
        self.buttonTextColor = buttonTextColor
        self.bulletTypographyStyle = bulletTypographyStyle
        self.seccondarySubtitleTypographyStyle = seccondarySubtitleTypographyStyle
        self.actionButtonAlignment = actionButtonAlignment
        self.iconAlignment = iconAlignment
    }
    
    init(titleColor: UIColor,
         subtitleColor: UIColor,
         seccondarySubtitleColor: UIColor,
         bulletNumberColor: UIColor,
         bulletBorderColor: UIColor,
         separatorColor: UIColor,
         iconTintColor: UIColor?,
         titleTypographyStyle: TypographyStyle,
         subtitleTypographyStyle: TypographyStyle,
         buttonTypographyStyle: TypographyStyle,
         buttonTextColor: UIColor,
         bulletTypographyStyle: TypographyStyle,
         seccondarySubtitleTypographyStyle: TypographyStyle,
         actionButtonAlignment: UIStackView.Alignment,
         iconAlignment: UIStackView.Alignment) {
        self.leftTitleColor = titleColor
        self.leftSubtitleColor = subtitleColor
        self.rightTitleColor = titleColor
        self.rightSubtitleColor = subtitleColor
        self.seccondarySubtitleColor = seccondarySubtitleColor
        self.bulletNumberColor = bulletNumberColor
        self.bulletBorderColor = bulletBorderColor
        self.separatorColor = separatorColor
        self.iconTintColor = iconTintColor
        self.titleTypographyStyle = titleTypographyStyle
        self.subtitleTypographyStyle = subtitleTypographyStyle
        self.buttonTypographyStyle = buttonTypographyStyle
        self.buttonTextColor = buttonTextColor
        self.bulletTypographyStyle = bulletTypographyStyle
        self.seccondarySubtitleTypographyStyle = seccondarySubtitleTypographyStyle
        self.actionButtonAlignment = actionButtonAlignment
        self.iconAlignment = iconAlignment
    }
}
