//
//  ButtonThemeProvider.swift
//  UalaFareUI
//
//  Created by Luis Perez on 15/07/22.
//
// swiftlint:disable type_body_length

public protocol ButtonThemeProvider {
    func theme(for buttonType: UIFareButtonType,
               typographyProvider: ThemeTypographyProvider,
               theme: Theme) -> ButtonTheme
}

public final class DefaultButtonThemeProvider: ButtonThemeProvider {
    public init() { }
        
    public func theme(for buttonType: UIFareButtonType,
                      typographyProvider: ThemeTypographyProvider,
                      theme: Theme) -> ButtonTheme {
        
        let enabledConfiguration = enabledConfiguration(for: buttonType,
                                                        theme: theme,
                                                        darkBackground: buttonType.isPlacedOnDarkBackground)
        let disabledConfiguration = disabledConfiguration(for: buttonType,
                                                          theme: theme,
                                                          darkBackground: buttonType.isPlacedOnDarkBackground)
        
        let pressedConfiguration = pressedConfiguration(for: buttonType,
                                                        theme: theme,
                                                        darkBackground: buttonType.isPlacedOnDarkBackground)
        
        return UalaButtonTheme(enabledConfiguration: enabledConfiguration,
                               disabledConfiguration: disabledConfiguration,
                               pressedConfiguration: pressedConfiguration,
                               typographyStyle: typographyStyle(for: buttonType,
                                                                typographyProvider: typographyProvider),
                               contentInsets: contentInsets(for: buttonType),
                               cornerRadius: cornerRadius(for: buttonType),
                               showTitle: showTitle(for: buttonType),
                               showIcon: showIcon(for: buttonType),
                               iconSize: iconSize(for: buttonType),
                               buttonPreferedSize: .zero)
    }
    
    private func typographyStyle(for buttonType: UIFareButtonType,
                                 typographyProvider: ThemeTypographyProvider) -> TypographyStyle {
        switch buttonType {
        case .link:
            return .bodyMdRegular
            
        default:
            return typographyProvider.typographyStyle(for: .button(size: buttonType.size))
        }
    }
    
    private func cornerRadius(for buttonType: UIFareButtonType) -> CGFloat {
        return buttonHeight(for: buttonType) / 2
    }
    
    private func showIcon(for type: UIFareButtonType) -> Bool {
        return true
    }
    
    private func showTitle(for type: UIFareButtonType) -> Bool {
        switch type {
        case .primary, .seccondary, .textOnly:
            return true
            
        default:
            return false
        }
    }
    
    private func contentInsets(for type: UIFareButtonType) -> UIEdgeInsets {
        let edgePadding = edgePadding(type: type)

        switch type {
        case .iconOnly, .tabBar:
            return UIEdgeInsets(top: edgePadding, left: edgePadding, bottom: edgePadding, right: edgePadding)
            
        default:
            return UIEdgeInsets(top: 0, left: edgePadding, bottom: 0, right: edgePadding)
        }
    }
    
    private func edgePadding(type: UIFareButtonType) -> CGFloat {
        switch type {
        case .primary, .seccondary, .textOnly:
            switch type.size {
            case .large:
                return 24
            case .small, .medium:
                return 16
            }
            
        case .tabBar, .iconOnly:
            return 12
        case .link:
            return .zero
        }
    }
    
    private func buttonWidth(for buttonType: UIFareButtonType, hasIcon: Bool) -> CGFloat {
        switch buttonType {
        case .primary, .seccondary, .textOnly:
            switch buttonType.size {
            case .large:
                return 355
            case .small, .medium:
                return hasIcon ? 121 : 105
            }
        
        case .tabBar, .iconOnly:
            return 48
        case .link:
            return .zero
        }
    }
    
    private func buttonHeight(for buttonType: UIFareButtonType) -> CGFloat {
        
        switch buttonType {
        case .primary, .seccondary, .textOnly:
            switch buttonType.size {
            case .large:
                return 48
            case .small, .medium:
                return 32
            }
            
        case .iconOnly, .tabBar:
            return 48
        
        case .link:
            return .zero
        }
    }
    
    private func iconSize(for type: UIFareButtonType) -> CGSize {
        switch type {
        case .link:
            return CGSize(width: 16, height: 16)
            
        default:
            return CGSize(width: 24, height: 24)
        }
        
    }
    
    private func enabledConfiguration(for buttonType: UIFareButtonType, theme: Theme, darkBackground: Bool) -> ThemeableButtonConfiguration {
        if darkBackground {
            return enabledOnDarkConfiguration(for: buttonType, theme: theme)
        }
        switch buttonType {
        case .primary:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .primaryDefault),
                                           labelColor: theme.color(for: .neutralWhite),
                                           iconTintColor: theme.color(for: .neutralWhite),
                                           borderColor: theme.color(for: .primaryDefault),
                                           borderWidth: 0)
            
        case .seccondary:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: theme.color(for: .primaryDefault),
                                           iconTintColor: theme.color(for: .primaryDefault),
                                           borderColor: theme.color(for: .primaryDefault),
                                           borderWidth: 2)
            
        case .textOnly:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: theme.color(for: .primaryDefault),
                                           iconTintColor: theme.color(for: .primaryDefault),
                                           borderColor: theme.color(for: .primaryDefault),
                                           borderWidth: 0)
            
        case .iconOnly:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: .clear,
                                           iconTintColor: theme.color(for: .primaryDefault),
                                           borderColor: theme.color(for: .primaryDefault),
                                           borderWidth: 0)
            
        case .tabBar:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .primaryDefault),
                                           labelColor: .clear,
                                           iconTintColor: theme.color(for: .neutralWhite),
                                           borderColor: .clear,
                                           borderWidth: 0)
            
        case .link:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: theme.color(for: .primaryDefault),
                                           iconTintColor: theme.color(for: .primaryDefault),
                                           borderColor: .clear,
                                           borderWidth: .zero)
        }
    }
    
    private func enabledOnDarkConfiguration(for buttonType: UIFareButtonType, theme: Theme) -> ThemeableButtonConfiguration {
        switch buttonType {
        case .primary:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .neutralWhite),
                                           labelColor: theme.color(for: .primaryDefault),
                                           iconTintColor: theme.color(for: .primaryDefault),
                                           borderColor: .clear,
                                           borderWidth: 0)
            
        case .seccondary:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: theme.color(for: .neutralWhite),
                                           iconTintColor: theme.color(for: .neutralWhite),
                                           borderColor: theme.color(for: .neutralWhite),
                                           borderWidth: 2)
            
        case .textOnly:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: theme.color(for: .neutralWhite),
                                           iconTintColor: theme.color(for: .neutralWhite),
                                           borderColor: .clear,
                                           borderWidth: 0)
            
        case .iconOnly:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: .clear,
                                           iconTintColor: theme.color(for: .neutralWhite),
                                           borderColor: .clear,
                                           borderWidth: 0)
            
        case .tabBar:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .primaryDefault),
                                           labelColor: .clear,
                                           iconTintColor: theme.color(for: .neutralWhite),
                                           borderColor: .clear,
                                           borderWidth: 0)
        
        case .link:
            return enabledConfiguration(for: .link,
                                        theme: theme,
                                        darkBackground: false)
        }
    }
    
    private func disabledConfiguration(for buttonType: UIFareButtonType, theme: Theme, darkBackground: Bool) -> ThemeableButtonConfiguration {
        if darkBackground {
            return disabledOnDarkConfiguration(for: buttonType, theme: theme)
        }
        switch buttonType {
        case .primary:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .neutralLight),
                                           labelColor: theme.color(for: .neutralMiddle),
                                           iconTintColor: theme.color(for: .neutralMiddle),
                                           borderColor: theme.color(for: .neutralLight),
                                           borderWidth: 0)
            
        case .seccondary:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .neutralWhite),
                                           labelColor: theme.color(for: .neutralMiddle),
                                           iconTintColor: theme.color(for: .neutralMiddle),
                                           borderColor: theme.color(for: .neutralLight),
                                           borderWidth: 2)
            
        case .textOnly:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: theme.color(for: .neutralMiddle),
                                           iconTintColor: theme.color(for: .neutralMiddle),
                                           borderColor: .clear,
                                           borderWidth: 0)
            
        case .iconOnly:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: .clear,
                                           iconTintColor: theme.color(for: .neutralMiddle),
                                           borderColor: .clear,
                                           borderWidth: 0)
            
        case .tabBar:
            return enabledConfiguration(for: buttonType, theme: theme, darkBackground: darkBackground)
            
        case .link:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: theme.color(for: .neutralMiddle),
                                           iconTintColor: theme.color(for: .neutralMiddle),
                                           borderColor: .clear,
                                           borderWidth: .zero)
        }
    }
    
    private func disabledOnDarkConfiguration(for buttonType: UIFareButtonType, theme: Theme) -> ThemeableButtonConfiguration {
        switch buttonType {
        case .primary:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .primaryDark),
                                           labelColor: theme.color(for: .primaryDarker),
                                           iconTintColor: theme.color(for: .primaryDarker),
                                           borderColor: .clear,
                                           borderWidth: 0)
            
        case .seccondary:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: theme.color(for: .primaryDark),
                                           iconTintColor: theme.color(for: .primaryDark),
                                           borderColor: theme.color(for: .primaryDark),
                                           borderWidth: 2)
            
        case .textOnly:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: theme.color(for: .primaryDark),
                                           iconTintColor: theme.color(for: .primaryDark),
                                           borderColor: .clear,
                                           borderWidth: 0)
            
        case .iconOnly:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: .clear,
                                           iconTintColor: theme.color(for: .primaryDark),
                                           borderColor: .clear,
                                           borderWidth: 0)
            
        case .tabBar:
            return enabledConfiguration(for: buttonType, theme: theme, darkBackground: false)
            
        case .link:
            return disabledConfiguration(for: buttonType,
                                         theme: theme,
                                         darkBackground: false)
        }
    }
    
    private func pressedConfiguration(for buttonType: UIFareButtonType, theme: Theme, darkBackground: Bool) -> ThemeableButtonConfiguration {
        if darkBackground {
            return pressedOnDarkConfiguration(for: buttonType, theme: theme)
        }
        switch buttonType {
        case .primary:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .primaryDarker),
                                           labelColor: theme.color(for: .neutralWhite),
                                           iconTintColor: theme.color(for: .neutralWhite),
                                           borderColor: theme.color(for: .primaryDark),
                                           borderWidth: 0)
            
        case .seccondary:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .primaryLight),
                                           labelColor: theme.color(for: .primaryDarker),
                                           iconTintColor: theme.color(for: .primaryDarker),
                                           borderColor: theme.color(for: .primaryDarker),
                                           borderWidth: 2)
            
        case .textOnly:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .primaryLighter),
                                           labelColor: theme.color(for: .primaryDarker),
                                           iconTintColor: theme.color(for: .primaryDarker),
                                           borderColor: theme.color(for: .primaryDarker),
                                           borderWidth: 2)
            
        case .iconOnly:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .primaryLight),
                                           labelColor: .clear,
                                           iconTintColor: theme.color(for: .primaryDefault),
                                           borderColor: .clear,
                                           borderWidth: 0)
            
        case .tabBar:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .primaryDarker),
                                           labelColor: .clear,
                                           iconTintColor: theme.color(for: .neutralWhite),
                                           borderColor: .clear,
                                           borderWidth: 0)
            
        case .link:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: theme.color(for: .primaryDarker),
                                           iconTintColor: theme.color(for: .informationDark),
                                           borderColor: .clear,
                                           borderWidth: .zero)
        }
    }
    
    private func pressedOnDarkConfiguration(for buttonType: UIFareButtonType, theme: Theme) -> ThemeableButtonConfiguration {
        switch buttonType {
        case .primary:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .primaryDark),
                                           labelColor: theme.color(for: .neutralWhite),
                                           iconTintColor: theme.color(for: .neutralWhite),
                                           borderColor: .clear,
                                           borderWidth: 0)
            
        case .seccondary:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .primaryDark),
                                           labelColor: theme.color(for: .neutralWhite),
                                           iconTintColor: theme.color(for: .neutralWhite),
                                           borderColor: theme.color(for: .neutralWhite),
                                           borderWidth: 2)
            
        case .textOnly:
            return UalaButtonConfiguration(backgroundColor: .clear,
                                           labelColor: theme.color(for: .primaryDarker),
                                           iconTintColor: theme.color(for: .primaryDarker),
                                           borderColor: theme.color(for: .primaryDarker),
                                           borderWidth: 2)
            
        case .iconOnly:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .primaryLight),
                                           labelColor: .clear,
                                           iconTintColor: theme.color(for: .primaryDefault),
                                           borderColor: .clear,
                                           borderWidth: 0)
            
        case .tabBar:
            return UalaButtonConfiguration(backgroundColor: theme.color(for: .primaryDarker),
                                           labelColor: .clear,
                                           iconTintColor: theme.color(for: .neutralWhite),
                                           borderColor: .clear,
                                           borderWidth: 0)
            
        case .link:
            return pressedConfiguration(for: buttonType,
                                        theme: theme,
                                        darkBackground: false)
        }
    }
}
