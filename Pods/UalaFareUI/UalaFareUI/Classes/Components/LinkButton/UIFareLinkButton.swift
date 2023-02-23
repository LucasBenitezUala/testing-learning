//
//  UIFareLinkButton.swift
//  UalaFareUI
//
//  Created by Luis Perez on 25/10/22.
//
// swiftlint:disable force_unwrapping

import UIKit

final public class UIFareLinkButton: UIButton {
    private lazy var linkIconImage: UIImage = {
        return UIImage(withAsset: DefaultIcons.externalLink)!
    }()
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width + 4,
                      height: super.intrinsicContentSize.height)
    }
    
    public override var isHighlighted: Bool {
        didSet {
            updateIconTintColor()
            updateAttributedTextColor()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            updateIconTintColor()
            updateAttributedTextColor()
        }
    }
    
    private let theme: ButtonTheme
    
    public init(frame: CGRect = .zero,
                theme: ButtonTheme = MainThemeManager.shared.buttonTheme(for: .link)) {
        self.theme = theme
        super.init(frame: frame)
        setLinkIcon(linkIconImage)
        configureTitleLabel()
    }
    
    public override init(frame: CGRect) {
        theme = MainThemeManager.shared.buttonTheme(for: .link)
        super.init(frame: frame)
        setLinkIcon(linkIconImage)
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        theme = MainThemeManager.shared.buttonTheme(for: .link)
        super.init(coder: coder)
        setLinkIcon(linkIconImage)
        configureTitleLabel()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        configureImageEdgeInsets()
    }
    
    public override func setImage(_ image: UIImage?, for state: UIControl.State) {
        return
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        let attributedText = NSMutableAttributedString(string: title ?? "")
        attributedText.addAttributes(titleAttributes(),
                                     range: NSRange(location: 0,
                                                    length: title?.count ?? 0))
        setAttributedTitle(attributedText, for: [])
    }
    
    private func titleAttributes() -> [NSAttributedString.Key: Any] {
        return [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: titleColor(),
            .foregroundColor: titleColor()
        ]
    }
    
    private func titleColor() -> UIColor {
        if !isEnabled {
            return theme.disabledConfiguration.labelColor
        } else {
            if isHighlighted {
                return theme.pressedConfiguration.labelColor
            }
            return theme.enabledConfiguration.labelColor
        }
    }
    
    private func configureTitleLabel() {
        setTitleColor(theme.enabledConfiguration.labelColor,
                      for: .normal)
        setTitleColor(theme.pressedConfiguration.labelColor,
                      for: .highlighted)
        setTitleColor(theme.disabledConfiguration.labelColor,
                      for: .disabled)
        self.titleLabel?.applyTypography(theme.typographyStyle)
    }
    
    public func setLinkIcon(_ icon: UIImage) {
        let customizedIcon: UIImage
        imageView?.contentMode = .scaleAspectFit
        
        if icon.size != theme.iconSize {
            customizedIcon = ImageResizer.resizeImage(theme.iconSize.width,
                                                       image: icon,
                                                       opaque: false)
        } else {
            customizedIcon = icon
        }
        
        updateIconTintColor(icon: customizedIcon)
    }
    
    private func updateAttributedTextColor() {
        guard let attributedText = titleLabel?.attributedText else {
            return
        }
        
        setTitle(attributedText.string, for: [])
    }
    
    private func updateIconTintColor(icon: UIImage? = nil) {
        var tintColor: UIColor
        
        if !isEnabled {
            tintColor = theme.disabledConfiguration.iconTintColor
        } else {
            if isHighlighted {
                tintColor = theme.pressedConfiguration.iconTintColor
            } else {
                tintColor = theme.enabledConfiguration.iconTintColor
            }
        }
        
        imageView?.tintColor = tintColor
        
        guard let icon = icon else {
            super.setImage(imageView?.image?.withTintColor(tintColor,
                                                           renderingMode: .alwaysTemplate),
                           for: [])
            return
        }
        
        super.setImage(icon.withTintColor(tintColor,
                                          renderingMode: .alwaysTemplate),
                       for: [])
    }
    
    private func configureImageEdgeInsets() {
        guard let imageView = self.imageView,
              let titleLabel = self.titleLabel else { return }
        self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                            left: -imageView.frame.size.width - 2,
                                            bottom: 0,
                                            right: imageView.frame.size.width)
        self.imageEdgeInsets = UIEdgeInsets(top: 0,
                                            left: titleLabel.frame.size.width + 2,
                                            bottom: 0,
                                            right: -titleLabel.frame.size.width)
    }
}
