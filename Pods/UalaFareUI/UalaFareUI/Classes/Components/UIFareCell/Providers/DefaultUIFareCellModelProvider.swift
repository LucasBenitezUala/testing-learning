//
//  DefaultDynamicInfoCellModelProvider.swift
//  UalaFareUI
//
//  Created by Luis Perez on 27/07/22.
//

// swiftlint:disable function_body_length
// swiftlint:disable type_body_length

import UIKit

final class DefaultUIFareCellModelProvider: UIFareCellModelProvider {
    func model(theme: Theme,
               typographyProvider: ThemeTypographyProvider,
               type: UIFareCellType) -> UIFareCellModel {
        
        switch type {
        case .simpleNonActionable(let leftTitle,
                                  let leftSubtitle,
                                  let rightTitle,
                                  let rightSubtitle,
                                  let leftIndicator,
                                  _,
                                  let swapTitleWithSubtitle,
                                  let showSeparator):
            return DynamicCellThemedModel(leftTitle: leftTitle,
                                          leftSubtitle: leftSubtitle,
                                          leftSeccondarySubtitle: nil,
                                          icon: cellIcon(for: leftIndicator, cellType: type),
                                          rightTitle: rightTitle,
                                          rightSubtitle: rightSubtitle,
                                          rightTag: nil,
                                          shouldAddDivider: showSeparator,
                                          actionButton: nil,
                                          pressedCellBackgroundColor: UIColor.clear,
                                          theme: cellTheme(movementCellStatus: nil,
                                                           theme: theme,
                                                           typographyProvider: typographyProvider,
                                                           type: type),
                                          tagTheme: theme.tagThemedModel(status: .negative, size: .small),
                                          switchTheme: theme.toggleThemedModel(),
                                          radioButtonTheme: theme.radioButtonTheme(),
                                          checkboxTheme: theme.checkboxTheme(),
                                          isSubtitleAtTop: swapTitleWithSubtitle)
            
        case .simpleActionable(let leftTitle,
                               let leftSubtitle,
                               let icon,
                               let button,
                               _,
                               let swapTitleWithSubtitle,
                               let showSeparator):
            return DynamicCellThemedModel(leftTitle: leftTitle,
                                          leftSubtitle: leftSubtitle,
                                          leftSeccondarySubtitle: nil,
                                          icon: cellIcon(for: icon,
                                                         cellType: type),
                                          rightTitle: nil,
                                          rightSubtitle: nil,
                                          rightTag: nil,
                                          shouldAddDivider: showSeparator,
                                          actionButton: button,
                                          pressedCellBackgroundColor: .clear,
                                          theme: cellTheme(movementCellStatus: nil,
                                                           theme: theme,
                                                           typographyProvider: typographyProvider,
                                                           type: type),
                                          tagTheme: theme.tagThemedModel(status: .negative, size: .small),
                                          switchTheme: theme.toggleThemedModel(),
                                          radioButtonTheme: theme.radioButtonTheme(),
                                          checkboxTheme: theme.checkboxTheme(),
                                          isSubtitleAtTop: swapTitleWithSubtitle)
            
        case .movement(let leftTitle,
                       let leftSubtitle,
                       let icon,
                       let rightTitle,
                       let rigthSubtitle,
                       let status,
                       let actionButton,
                       let showSeparator):
            return DynamicCellThemedModel(leftTitle: leftTitle,
                                          leftSubtitle: leftSubtitle,
                                          leftSeccondarySubtitle: nil,
                                          icon: .icon(image: icon, size: .medium),
                                          rightTitle: rightTitle,
                                          rightSubtitle: rigthSubtitle,
                                          rightTag: nil,
                                          shouldAddDivider: showSeparator,
                                          actionButton: actionButton,
                                          pressedCellBackgroundColor: .clear,
                                          theme: cellTheme(movementCellStatus: status,
                                                           theme: theme,
                                                           typographyProvider: typographyProvider,
                                                           type: type),
                                          tagTheme: theme.tagThemedModel(status: .negative, size: .small),
                                          switchTheme: theme.toggleThemedModel(),
                                          radioButtonTheme: theme.radioButtonTheme(),
                                          checkboxTheme: theme.checkboxTheme(),
                                          isSubtitleAtTop: false)
            
        case .avatar(let leftTitle,
                     let leftSubtitle,
                     let leftSeccondarySubtitle,
                     let icon,
                     let rightTitle,
                     let rightSubtitle,
                     let rightTag,
                     let button,
                     let showSeparator):
            return DynamicCellThemedModel(leftTitle: leftTitle,
                                          leftSubtitle: leftSubtitle,
                                          leftSeccondarySubtitle: leftSeccondarySubtitle,
                                          icon: .icon(image: icon, size: .large, isRounded: true),
                                          rightTitle: rightTitle,
                                          rightSubtitle: rightSubtitle,
                                          rightTag: rightTag,
                                          shouldAddDivider: showSeparator,
                                          actionButton: button,
                                          pressedCellBackgroundColor: .clear,
                                          theme: cellTheme(movementCellStatus: nil,
                                                           theme: theme,
                                                           typographyProvider: typographyProvider,
                                                           type: type),
                                          tagTheme: theme.tagThemedModel(status: rightTag?.status ?? .negative, size: .small),
                                          switchTheme: theme.toggleThemedModel(),
                                          radioButtonTheme: theme.radioButtonTheme(),
                                          checkboxTheme: theme.checkboxTheme(),
                                          isSubtitleAtTop: false)
        case .checkbox(let leftTitle,
                       let leftSubtitle,
                       let rightTitle,
                       let rightSubtitle,
                       let size,
                       let showSeparator):
            return DynamicCellThemedModel(leftTitle: leftTitle,
                                          leftSubtitle: leftSubtitle,
                                          leftSeccondarySubtitle: nil,
                                          icon: nil,
                                          rightTitle: rightTitle,
                                          rightSubtitle: rightSubtitle,
                                          rightTag: nil,
                                          shouldAddDivider: showSeparator,
                                          actionButton: .checkBox(size: size),
                                          pressedCellBackgroundColor: .clear,
                                          theme: cellTheme(movementCellStatus: nil,
                                                           theme: theme,
                                                           typographyProvider: typographyProvider,
                                                           type: type),
                                          tagTheme: theme.tagThemedModel(status: .negative, size: .small),
                                          switchTheme: theme.toggleThemedModel(),
                                          radioButtonTheme: theme.radioButtonTheme(),
                                          checkboxTheme: theme.checkboxTheme(),
                                          isSubtitleAtTop: false)
        case .radioButton(let leftTitle,
                          let leftSubtitle,
                          let rightTitle,
                          let rightSubtitle,
                          let size,
                          let showSeparator):
            return DynamicCellThemedModel(leftTitle: leftTitle,
                                          leftSubtitle: leftSubtitle,
                                          leftSeccondarySubtitle: nil,
                                          icon: nil,
                                          rightTitle: rightTitle,
                                          rightSubtitle: rightSubtitle,
                                          rightTag: nil,
                                          shouldAddDivider: showSeparator,
                                          actionButton: .radio(size: size),
                                          pressedCellBackgroundColor: .clear,
                                          theme: cellTheme(movementCellStatus: nil,
                                                           theme: theme,
                                                           typographyProvider: typographyProvider,
                                                           type: type),
                                          tagTheme: theme.tagThemedModel(status: .negative, size: .small),
                                          switchTheme: theme.toggleThemedModel(),
                                          radioButtonTheme: theme.radioButtonTheme(),
                                          checkboxTheme: theme.checkboxTheme(),
                                          isSubtitleAtTop: false)
        case .switchButton(let title,
                           let subtitle,
                           let icon):
            return DynamicCellThemedModel(leftTitle: title,
                                          leftSubtitle: subtitle,
                                          leftSeccondarySubtitle: nil,
                                          icon: .icon(image: icon,
                                                      size: .small),
                                          rightTitle: nil,
                                          rightSubtitle: nil,
                                          rightTag: nil,
                                          shouldAddDivider: false,
                                          actionButton: .switch,
                                          pressedCellBackgroundColor: .clear,
                                          theme: cellTheme(movementCellStatus: nil,
                                                           theme: theme,
                                                           typographyProvider: typographyProvider,
                                                           type: type),
                                          tagTheme: theme.tagThemedModel(status: .negative, size: .small),
                                          switchTheme: theme.toggleThemedModel(),
                                          radioButtonTheme: theme.radioButtonTheme(),
                                          checkboxTheme: theme.checkboxTheme(),
                                          isSubtitleAtTop: false)
        case .tag(let title,
                  let subtitle,
                  let icon,
                  let tag,
                  let showSeparator):
            return DynamicCellThemedModel(leftTitle: title,
                                          leftSubtitle: subtitle,
                                          leftSeccondarySubtitle: nil,
                                          icon: .icon(image: icon,
                                                      size: .small),
                                          rightTitle: nil,
                                          rightSubtitle: nil,
                                          rightTag: tag,
                                          shouldAddDivider: showSeparator,
                                          actionButton: nil,
                                          pressedCellBackgroundColor: .clear,
                                          theme: cellTheme(movementCellStatus: nil,
                                                           theme: theme,
                                                           typographyProvider: typographyProvider,
                                                           type: type),
                                          tagTheme: theme.tagThemedModel(status: tag.status, size: .medium),
                                          switchTheme: theme.toggleThemedModel(),
                                          radioButtonTheme: theme.radioButtonTheme(),
                                          checkboxTheme: theme.checkboxTheme(),
                                          isSubtitleAtTop: false)
        case .chevron(let title,
                      let subtitle,
                      let swapTitleWithSubtitle,
                      let icon):
            let iconImage = UIImage(withName: "right") ?? UIImage()
            
            return DynamicCellThemedModel(leftTitle: title,
                                          leftSubtitle: subtitle,
                                          leftSeccondarySubtitle: nil,
                                          icon: cellIcon(for: icon, cellType: type),
                                          rightTitle: nil,
                                          rightSubtitle: nil,
                                          rightTag: nil,
                                          shouldAddDivider: true,
                                          actionButton: .icon(image: iconImage),
                                          pressedCellBackgroundColor: .clear,
                                          theme: cellTheme(movementCellStatus: nil,
                                                           theme: theme,
                                                           typographyProvider: typographyProvider,
                                                           type: type),
                                          tagTheme: theme.tagThemedModel(status: .new, size: .small),
                                          switchTheme: theme.toggleThemedModel(),
                                          radioButtonTheme: theme.radioButtonTheme(),
                                          checkboxTheme: theme.checkboxTheme(),
                                          isSubtitleAtTop: swapTitleWithSubtitle)
        }
    }
    
    private func cellIcon(for indicator: UIFareCellIndicator?, cellType: UIFareCellType) -> UIFareCellIconType? {
        guard let indicator = indicator else {
            return nil
        }

        switch indicator {
        case .bulletNumber(let number):
            return .bulletNumber(number: number)
        case .icon(let image):
            switch cellType {
            case .simpleNonActionable, .simpleActionable, .switchButton, .tag, .chevron:
                return .icon(image: image, size: .small, isRounded: false)
                
            case .movement:
                return .icon(image: image, size: .medium, isRounded: false)
                
            case .avatar:
                return .icon(image: image, size: .large, isRounded: true)
            default:
                return nil
            }
        }
    }
    
    private func cellTheme(movementCellStatus: UIFareMovementCellStatus?,
                           theme: Theme,
                           typographyProvider: ThemeTypographyProvider,
                           type: UIFareCellType) -> UIFareCellTheme {
        
        guard let movementCellStatus = movementCellStatus, movementCellStatus != .none else {
            return DefaultDynamicCellTheme(titleColor: theme.color(for: .neutralDarker),
                                           subtitleColor: theme.color(for: .neutralDark),
                                           seccondarySubtitleColor: theme.color(for: .neutralDarker),
                                           bulletNumberColor: theme.color(for: .neutralDark),
                                           bulletBorderColor: theme.color(for: .neutralDark),
                                           separatorColor: theme.color(for: .neutralLight),
                                           iconTintColor: iconTintColor(type: type, theme: theme),
                                           titleTypographyStyle: typographyProvider.typographyStyle(for: .dynamicCell(type: type, component: .title)),
                                           subtitleTypographyStyle: typographyProvider.typographyStyle(for: .dynamicCell(type: type, component: .subtitle)),
                                           buttonTypographyStyle: typographyProvider.typographyStyle(for: .dynamicCell(type: type, component: .button)),
                                           buttonTextColor: theme.color(for: .primaryDefault),
                                           bulletTypographyStyle: typographyProvider.typographyStyle(for: .dynamicCell(type: type, component: .bulletNumber)),
                                           seccondarySubtitleTypographyStyle: typographyProvider.typographyStyle(for: .dynamicCell(type: type, component: .seccondarySubtitle)),
                                           actionButtonAlignment: actionButtonAlignment(for: type),
                                           iconAlignment: iconAlignment(for: type))
        }
        
        let leftSubtitleColor: UIColor
        let rightTitleColor: UIColor
        
        switch movementCellStatus {
        case .error:
            leftSubtitleColor = theme.color(for: .errorMiddle)
            rightTitleColor = theme.color(for: .neutralDarker)
        case .success, .none:
            leftSubtitleColor = theme.color(for: .neutralDark)
            rightTitleColor = theme.color(for: .successMiddle)
        }
        
        return DefaultDynamicCellTheme(leftTitleColor: theme.color(for: .neutralDarker),
                                       leftSubtitleColor: leftSubtitleColor,
                                       rightTitleColor: rightTitleColor,
                                       rightSubtitleColor: theme.color(for: .neutralDark),
                                       seccondarySubtitleColor: theme.color(for: .neutralDarker),
                                       bulletNumberColor: theme.color(for: .neutralDark),
                                       bulletBorderColor: theme.color(for: .neutralDark),
                                       separatorColor: theme.color(for: .neutralLight),
                                       iconTintColor: iconTintColor(type: type, theme: theme),
                                       titleTypographyStyle: typographyProvider.typographyStyle(for: .dynamicCell(type: type, component: .title)),
                                       subtitleTypographyStyle: typographyProvider.typographyStyle(for: .dynamicCell(type: type, component: .subtitle)),
                                       buttonTypographyStyle: typographyProvider.typographyStyle(for: .dynamicCell(type: type, component: .button)),
                                       buttonTextColor: theme.color(for: .primaryDefault),
                                       bulletTypographyStyle: typographyProvider.typographyStyle(for: .dynamicCell(type: type, component: .bulletNumber)),
                                       seccondarySubtitleTypographyStyle: typographyProvider.typographyStyle(for: .dynamicCell(type: type, component: .seccondarySubtitle)),
                                       actionButtonAlignment: actionButtonAlignment(for: type),
                                       iconAlignment: iconAlignment(for: type))
    }
    
    private func actionButtonAlignment(for type: UIFareCellType) -> UIStackView.Alignment {
        switch type {
        case .movement:
            return .center
        default:
            return .top
        }
    }
    
    private func iconAlignment(for type: UIFareCellType) -> UIStackView.Alignment {
        switch type {
        case .movement:
            return .center
        default:
            return .top
        }
    }
    
    private func iconTintColor(type: UIFareCellType, theme: Theme) -> UIColor? {
        switch type {
        case .simpleNonActionable, .simpleActionable, .switchButton, .tag, .chevron:
            return theme.color(for: .neutralDark)
            
        default:
            return nil
        }
    }
}
