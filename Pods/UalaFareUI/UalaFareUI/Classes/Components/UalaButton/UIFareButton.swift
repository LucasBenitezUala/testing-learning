//
//  UalaButton.swift
//  UalaDSDemo
//
//  Created by Luis Perez on 04/07/22.
//

import UIKit

final public class UIFareButton: UIButton {
    private var theme: ButtonTheme?
    
    public override var isHighlighted: Bool {
        didSet {
            buttonStatusUpdated()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            buttonStatusUpdated()
        }
    }
    
    public init(theme: ButtonTheme, frame: CGRect) {
        self.theme = theme
        super.init(frame: frame)
        buttonStatusUpdated()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buttonStatusUpdated()
    }
    
    public override func setImage(_ image: UIImage?, for state: UIControl.State) {
        guard let theme = theme else { return }
        
        let tintColor: UIColor
            
        if !isEnabled {
            tintColor = theme.disabledConfiguration.iconTintColor
        } else {
            if isHighlighted {
                tintColor = theme.pressedConfiguration.iconTintColor
            } else {
                tintColor = theme.enabledConfiguration.iconTintColor
            }
        }
        
        configureIcon(icon: image,
                      tintColor: tintColor,
                      state: state)
        updateTitleInsets()
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        guard let theme = theme, theme.showTitle else {
            return
        }
        super.setTitle(title, for: [])
        titleLabel?.applyTypography(theme.typographyStyle)
        updateTitleInsets()
    }
    
    private func buttonStatusUpdated() {
        guard let theme = self.theme else { return }
        let config: ThemeableButtonConfiguration
        
        setCommonButtonConfiguration(for: theme)
        
        if !isEnabled {
            config = theme.disabledConfiguration
        } else {
            if isHighlighted {
                config = theme.pressedConfiguration
            } else {
                config = theme.enabledConfiguration
            }
        }
        
        configureButtonState(backgroundColor: config.backgroundColor,
                             borderColor: config.borderColor.cgColor,
                             borderWidth: config.borderWidth)
        if theme.showIcon {
            configureIcon(icon: imageView?.image,
                          tintColor: config.iconTintColor)
        } else {
            configureIcon(icon: nil, tintColor: config.iconTintColor)
        }
        
        if !theme.showTitle {
            self.setTitle(nil, for: [])
            self.titleLabel?.text = nil
        }
        updateTitleInsets()
    }
    
    private func setCommonButtonConfiguration(for theme: ButtonTheme) {
        adjustsImageWhenHighlighted = false
        adjustsImageWhenDisabled = false
        titleLabel?.numberOfLines = 1
        titleLabel?.lineBreakMode = .byTruncatingTail
        layer.cornerRadius = theme.cornerRadius
        titleLabel?.applyTypography(theme.typographyStyle)
        setTitleColor(theme.enabledConfiguration.labelColor, for: .normal)
        setTitleColor(theme.disabledConfiguration.labelColor, for: .disabled)
        setTitleColor(theme.pressedConfiguration.labelColor, for: .highlighted)
        configureContentEdgeInsets(edgeInsets: theme.contentInsets)
    }
    
    private func configureButtonState(backgroundColor: UIColor,
                                      borderColor: CGColor,
                                      borderWidth: CGFloat) {
        
        self.backgroundColor = backgroundColor
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
    }
    
    private func configureIcon(icon: UIImage?, tintColor: UIColor, state: UIControl.State = []) {
        guard let icon = icon, let iconSize = theme?.iconSize else {
            super.setImage(icon, for: state)
            imageView?.image = icon
            return
        }
        
        imageView?.contentMode = .scaleAspectFit
        
        if icon.size.width != iconSize.width {
            let resizedIcon = ImageResizer.resizeImage(iconSize.width, image: icon, opaque: false).withTintColor(tintColor, renderingMode: .alwaysOriginal)
            super.setImage(resizedIcon, for: state)
        } else {
            let resizedIcon = icon.withTintColor(tintColor, renderingMode: .alwaysOriginal)
            super.setImage(resizedIcon, for: state)
        }
    }
    
    private func configureContentEdgeInsets(edgeInsets: UIEdgeInsets) {
        contentEdgeInsets = edgeInsets
    }
    
    private func updateTitleInsets() {
        if imageView?.image != nil {
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        } else {
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    public func setTheme(_ theme: ButtonTheme) {
        self.theme = theme
        buttonStatusUpdated()
    }
    
    public override var intrinsicContentSize: CGSize {
        let height = super.intrinsicContentSize.height
        let width = super.intrinsicContentSize.width + titleEdgeInsets.left
        return CGSize(width: width, height: height)
    }
}
