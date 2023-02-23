//
//  DefaultUIFareCardModelFactory.swift
//  UalaFareUI
//
//  Created by Luis Perez on 08/09/22.
//

// swiftlint:disable all
final class DefaultUIFareCardModelFactory: UIFareCardModelFactory {
    private let typographyFactory: UIFareCardTypographyFactory
    
    init(typographyFactory: UIFareCardTypographyFactory) {
        self.typographyFactory = typographyFactory
    }
    
    convenience init() {
        self.init(typographyFactory: DefaultUIFareCardTypographyFactory())
    }
    
    func themedModel(for type: UIFareCardType, theme: Theme) -> UIFareCardModel {
        let enabledConfiguration = enabledConfiguration(for: type, theme: theme)
        let pressedConfiguration = pressedConfiguration(for: type, theme: theme)
        let disabledConfiguration = disabledConfiguration(for: type, theme: theme)
        let titleTypography = typographyFactory.style(for: type, component: .title)
        let subtitleTypography = typographyFactory.style(for: type, component: .subtitle)
        let scoreTypographyStyle = typographyFactory.style(for: type, component: .rating)
        
        return DefaultUIFareCardModel(titleTypographyStyle: titleTypography,
                                      subtitleTypographyStyle: subtitleTypography,
                                      scoreTypographyStyle: scoreTypographyStyle,
                                      type: type,
                                      enabledConfiguration: enabledConfiguration,
                                      disabledConfiguration: disabledConfiguration,
                                      pressedConfiguration: pressedConfiguration,
                                      edgeInsets: edgeInsets(for: type),
                                      imageSize: imageSize(for: type),
                                      imageCornerRadius: imageCornerRadius(for: type),
                                      generalSpacing: generalSpacing(for: type),
                                      spacingBetwenLabels: spacingBetweenLabels(for: type),
                                      orientation: orientation(for: type),
                                      textAlignment: textAlignment(for: type),
                                      showScore: type == .rating,
                                      showHeaderImage: type == .rating,
                                      showSubtitle: showSubtitle(for: type),
                                      iconImageContentMode: iconImageContentMode(for: type),
                                      cardWidth: cardWidth(for: type),
                                      numberOfLinesForTitle: numberOfTitleLines(for: type),
                                      numberOfLinesForSubtitle: numberOfSubtitleLines(for: type),
                                      fixedSize: fixedSize(for: type))
    }
    
    private func enabledConfiguration(for type: UIFareCardType, theme: Theme) -> UIFareCardModelConfiguration {
        switch type {
        case .horizontalIcon, .verticalIconSmall, .verticalIconMiddle:
            return DefaultUIFareCardModelConfiguration(iconTintColor: theme.color(for: .primaryDefault),
                                                       backgroundColor: theme.color(for: .neutralWhite),
                                                       shadow: .shadowMd,
                                                       imageOpacity: 1.0,
                                                       titleColor: theme.color(for: .neutralDarker),
                                                       subtitleColor: theme.color(for: .neutralDark),
                                                       ratingColor: theme.color(for: .neutralDarker),
                                                       borderColor: .clear,
                                                       borderWidth: 0,
                                                       cornerRadius: 16)
            
        case .horizontalIconLarge:
            return DefaultUIFareCardModelConfiguration(iconTintColor: nil,
                                                       backgroundColor: theme.color(for: .neutralWhite),
                                                       shadow: .shadowMd,
                                                       imageOpacity: 1.0,
                                                       titleColor: theme.color(for: .neutralDarker),
                                                       subtitleColor: theme.color(for: .neutralDark),
                                                       ratingColor: theme.color(for: .neutralDarker),
                                                       borderColor: .clear,
                                                       borderWidth: 0,
                                                       cornerRadius: 16)
        case .amount:
            return DefaultUIFareCardModelConfiguration(iconTintColor: theme.color(for: .primaryDefault),
                                                       backgroundColor: theme.color(for: .neutralWhite),
                                                       shadow: .shadowMd,
                                                       imageOpacity: 1.0,
                                                       titleColor: theme.color(for: .primaryDefault),
                                                       subtitleColor: theme.color(for: .neutralDark),
                                                       ratingColor: theme.color(for: .neutralDarker),
                                                       borderColor: .clear,
                                                       borderWidth: 0,
                                                       cornerRadius: 16)
        case .avatar, .rating, .imageOnly, .avatarSmall:
            return DefaultUIFareCardModelConfiguration(iconTintColor: nil,
                                                       backgroundColor: theme.color(for: .neutralWhite),
                                                       shadow: .shadowMd,
                                                       imageOpacity: 1.0,
                                                       titleColor: theme.color(for: .neutralDarker),
                                                       subtitleColor: theme.color(for: .neutralDark),
                                                       ratingColor: theme.color(for: .neutralDarker),
                                                       borderColor: .clear,
                                                       borderWidth: 0,
                                                       cornerRadius: 16)
        case .quickAction:
            return DefaultUIFareCardModelConfiguration(iconTintColor: theme.color(for: .primaryDefault),
                                                       backgroundColor: theme.color(for: .neutralWhite),
                                                       shadow: nil,
                                                       imageOpacity: 1,
                                                       titleColor: theme.color(for: .primaryDefault),
                                                       subtitleColor: theme.color(for: .primaryDefault),
                                                       ratingColor: theme.color(for: .primaryDefault),
                                                       borderColor: theme.color(for: .neutralLight),
                                                       borderWidth: 1,
                                                       cornerRadius: 16)
        }
    }
    
    private func pressedConfiguration(for type: UIFareCardType, theme: Theme) -> UIFareCardModelConfiguration {
        switch type {
            // Change the spacing between labels on the amount card.
        case .horizontalIcon, .verticalIconMiddle, .verticalIconSmall:
            return DefaultUIFareCardModelConfiguration(iconTintColor: theme.color(for: .primaryDefault),
                                                       backgroundColor: theme.color(for: .primaryLighter),
                                                       shadow: .shadowMd,
                                                       imageOpacity: 1.0,
                                                       titleColor: theme.color(for: .neutralDarker),
                                                       subtitleColor: theme.color(for: .neutralDark),
                                                       ratingColor: theme.color(for: .neutralDarker),
                                                       borderColor: .clear,
                                                       borderWidth: 0,
                                                       cornerRadius: 16)
            
        case .amount:
            return DefaultUIFareCardModelConfiguration(iconTintColor: theme.color(for: .primaryDefault),
                                                       backgroundColor: theme.color(for: .primaryLighter),
                                                       shadow: .shadowMd,
                                                       imageOpacity: 1.0,
                                                       titleColor: theme.color(for: .neutralDarker),
                                                       subtitleColor: theme.color(for: .neutralDarker),
                                                       ratingColor: theme.color(for: .neutralDarker),
                                                       borderColor: .clear,
                                                       borderWidth: 0,
                                                       cornerRadius: 16)
            
        case .avatar:
            return DefaultUIFareCardModelConfiguration(iconTintColor: nil,
                                                       backgroundColor: theme.color(for: .primaryLighter),
                                                       shadow: .shadowMd,
                                                       imageOpacity: 1.0,
                                                       titleColor: theme.color(for: .neutralDarker),
                                                       subtitleColor: theme.color(for: .neutralDarker),
                                                       ratingColor: .clear,
                                                       borderColor: .clear,
                                                       borderWidth: 0,
                                                       cornerRadius: 16)
        
        case .rating, .avatarSmall, .imageOnly, .horizontalIconLarge:
            return DefaultUIFareCardModelConfiguration(iconTintColor: nil,
                                                       backgroundColor: theme.color(for: .primaryLighter),
                                                       shadow: .shadowMd,
                                                       imageOpacity: 1.0,
                                                       titleColor: theme.color(for: .neutralDarker),
                                                       subtitleColor: theme.color(for: .neutralDark),
                                                       ratingColor: .clear,
                                                       borderColor: .clear,
                                                       borderWidth: 0,
                                                       cornerRadius: 16)
            
        case .quickAction:
            return DefaultUIFareCardModelConfiguration(iconTintColor: theme.color(for: .neutralWhite),
                                                       backgroundColor: theme.color(for: .primaryDarker),
                                                       shadow: nil,
                                                       imageOpacity: 1,
                                                       titleColor: theme.color(for: .neutralWhite),
                                                       subtitleColor: .clear,
                                                       ratingColor: .clear,
                                                       borderColor: theme.color(for: .primaryDark),
                                                       borderWidth: 1,
                                                       cornerRadius: 16)
        }
    }
    
    private func disabledConfiguration(for type: UIFareCardType, theme: Theme) -> UIFareCardModelConfiguration {
        switch type {
        case .horizontalIconLarge, .rating, .avatarSmall, .avatar, .imageOnly:
            return DefaultUIFareCardModelConfiguration(iconTintColor: nil,
                                                       backgroundColor: theme.color(for: .neutralWhite),
                                                       shadow: nil,
                                                       imageOpacity: 0.5,
                                                       titleColor: theme.color(for: .neutralMiddle),
                                                       subtitleColor: theme.color(for: .neutralMiddle),
                                                       ratingColor: theme.color(for: .neutralMiddle),
                                                       borderColor: .clear,
                                                       borderWidth: 0,
                                                       cornerRadius: 16)
            
        case .quickAction:
            return DefaultUIFareCardModelConfiguration(iconTintColor: theme.color(for: .neutralLight),
                                                       backgroundColor: theme.color(for: .neutralWhite),
                                                       shadow: nil,
                                                       imageOpacity: 1.0,
                                                       titleColor: theme.color(for: .neutralLight),
                                                       subtitleColor: .clear,
                                                       ratingColor: .clear,
                                                       borderColor: theme.color(for: .neutralLight),
                                                       borderWidth: 1,
                                                       cornerRadius: 16)
        
        default:
            return DefaultUIFareCardModelConfiguration(iconTintColor: theme.color(for: .neutralMiddle),
                                                       backgroundColor: theme.color(for: .neutralWhite),
                                                       shadow: nil,
                                                       imageOpacity: 0.5,
                                                       titleColor: theme.color(for: .neutralMiddle),
                                                       subtitleColor: theme.color(for: .neutralMiddle),
                                                       ratingColor: theme.color(for: .neutralMiddle),
                                                       borderColor: .clear,
                                                       borderWidth: 0,
                                                       cornerRadius: 16)
        }
    }
    
    private func edgeInsets(for type: UIFareCardType) -> UIEdgeInsets {
        switch type {
        case .horizontalIcon, .horizontalIconLarge:
            return UIEdgeInsets(top: 16,
                                left: 16,
                                bottom: 16,
                                right: 16)
            
        case .verticalIconMiddle, .avatar:
            return UIEdgeInsets(top: 12,
                                left: 16,
                                bottom: 12,
                                right: 16)
        case .verticalIconSmall, .avatarSmall:
            return UIEdgeInsets(top: 24,
                                left: 4,
                                bottom: 8,
                                right: 4)
        case .imageOnly:
            return UIEdgeInsets(top: 16,
                                left: 88.5,
                                bottom: 16,
                                right: 88.5)
        case .amount:
            return UIEdgeInsets(top: 22,
                                left: 16,
                                bottom: 22,
                                right: 16)
            
        case .rating:
            return UIEdgeInsets(top: 54,
                                left: 12,
                                bottom: 12,
                                right: 12)
        case .quickAction:
            return UIEdgeInsets(top: 13,
                                left: 4,
                                bottom: 0,
                                right: 4)
        }
    }
    
    private func orientation(for type: UIFareCardType) -> NSLayoutConstraint.Axis {
        switch type {
        case .horizontalIcon, .horizontalIconLarge, .imageOnly:
            return .horizontal
        default:
            return .vertical
        }
    }
    
    private func imageCornerRadius(for type: UIFareCardType) -> CGFloat {
        switch type {
        case .avatar, .rating, .avatarSmall:
            return imageSize(for: type).height / 2
        default:
            return .zero
        }
    }
    
    private func imageSize(for type: UIFareCardType) -> CGSize {
        switch type {
        case .horizontalIcon, .verticalIconMiddle, .verticalIconSmall, .avatarSmall:
            return CGSize(width: 32,
                          height: 32)
            
        case .horizontalIconLarge:
            return CGSize(width: 80,
                          height: 80)
            
        case .imageOnly:
            return CGSize(width: 158,
                          height: 34)

        case .amount:
            return .zero
            
        case .avatar, .rating:
            return CGSize(width: 40,
                          height: 40)
        case .quickAction:
            return CGSize(width: 32,
                          height: 32)
        }
    }
    
    private func spacingBetweenLabels(for type: UIFareCardType) -> CGFloat {
        switch type {
        case .horizontalIcon, .imageOnly, .quickAction, .horizontalIconLarge, .rating, .avatar, .verticalIconMiddle:
            return Spacings.spacing1.value
        case .amount:
            return Spacings.spacing2.value
        case .verticalIconSmall:
            return 0
        case .avatarSmall:
            return 8
        }
    }
    
    private func generalSpacing(for type: UIFareCardType) -> CGFloat {
        switch type {
        case .horizontalIcon, .horizontalIconLarge:
            return 16
            
        case .verticalIconMiddle, .verticalIconSmall, .avatar, .rating, .avatarSmall:
            return 8
            
        case .imageOnly:
            return .zero
            
        case .amount:
            return .zero
            
        case .quickAction:
            return 4
        }
    }
    
    private func textAlignment(for type: UIFareCardType) -> UIStackView.Alignment {
        switch type {
        case .horizontalIcon, .horizontalIconLarge, .imageOnly:
            return .leading
        default:
            return .center
        }
    }
    
    private func iconImageContentMode(for type: UIFareCardType) -> UIView.ContentMode {
        switch type {
        case .avatar, .avatarSmall, .imageOnly, .rating:
            return .scaleAspectFill
        default:
            return .scaleAspectFit
        }
    }
    
    private func cardWidth(for type: UIFareCardType) -> CGFloat {
        switch type {
        case .horizontalIcon, .horizontalIconLarge, .imageOnly:
            return 335
        case .verticalIconMiddle, .amount, .avatar, .rating:
            return 158
        case .verticalIconSmall, .avatarSmall:
            return 100
        case .quickAction:
            return 72
        }
    }
    
    private func showSubtitle(for type: UIFareCardType) -> Bool {
        switch type {
        case .horizontalIcon, .horizontalIconLarge, .verticalIconMiddle, .amount, .avatar, .rating:
            return true
        case .verticalIconSmall, .imageOnly, .avatarSmall, .quickAction:
            return false
        }
    }
    
    private func numberOfTitleLines(for type: UIFareCardType) -> Int {
        switch type {
        case .avatarSmall, .verticalIconSmall, .quickAction:
            return 2
        default:
            return 1
        }
    }
    
    private func numberOfSubtitleLines(for type: UIFareCardType) -> Int {
        switch type {
        case .horizontalIconLarge:
            return 3
        case .verticalIconMiddle, .avatar, .rating:
            return 2
        default:
            return 1
        }
    }
    
    private func fixedSize(for type: UIFareCardType) -> CGSize? {
        switch type {
        case .quickAction:
            return CGSize(width: 72, height: 72)
        case .verticalIconSmall:
            return CGSize(width: 98, height: 100)
        default:
            return nil
        }
    }
}
