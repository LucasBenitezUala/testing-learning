//
//  DynamicInformationTableViewCell.swift
//  UalaFareUI
//
//  Created by Luis Perez on 23/07/22.
//

// swiftlint:disable type_body_length
// swiftlint:disable file_length
// swiftlint:disable function_parameter_count

import UIKit

final public class UIFareCell: UITableViewCell {
    private lazy var mainStackView: UIStackView = {
        return configureStackView()
    }()
    
    public var isCheckboxSelected: Bool {
        return checkbox?.isCheckboxSelected ?? false
    }
    
    public var isToggleOn: Bool {
        return toggle?.isOn ?? false
    }
    
    public var isRadioSelected: Bool {
        return radioButton?.isRadioSelected ?? false
    }
    
    private var separator: UIView?
    private weak var delegate: UIFareCellDelegate?
    private var indexPath: IndexPath?
    private weak var checkbox: UIFareCheckbox?
    private weak var toggle: UIFareSwitch?
    private weak var radioButton: UIFareRadioButton?
    
    public func setDelegate(delegate: UIFareCellDelegate, indexPath: IndexPath) {
        self.delegate = delegate
        self.indexPath = indexPath
    }
    
    public func configure(with model: UIFareCellModel) {
        configureCell()
        configureLeftStackViewIfNeeded(with: model)
        configureCentralStackView(model: model)
        configureRightStackIfNeeded(with: model)
        configureSeparatorIfNeeded(model: model)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }
    
    public func setCheckboxStatus(isSelected: Bool) {
        checkbox?.isCheckboxSelected = isSelected
    }
    
    public func setSwitchStatus(isOn: Bool) {
        toggle?.isOn = isOn
    }
    
    public func setRadioButtonStatus(isSelected: Bool) {
        radioButton?.isRadioSelected = isSelected
    }
    
    private func resetCell() {
        separator?.isHidden = true
        mainStackView.removeFromSuperview()
        mainStackView = configureStackView()
    }
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    private func configureSeparatorIfNeeded(model: UIFareCellModel) {
        if model.shouldAddDivider {
            if let separator = separator {
                separator.isHidden = false
                return
            }
            
            let separator = UIView()
            
            separator.translatesAutoresizingMaskIntoConstraints = false
            separator.backgroundColor = model.theme.separatorColor
            contentView.addSubview(separator)
            
            let contentViewContraints = [
                NSLayoutConstraint(item: separator,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: contentView,
                                   attribute: .width,
                                   multiplier: 1,
                                   constant: 0),
                NSLayoutConstraint(item: separator,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: contentView,
                                   attribute: .bottom,
                                   multiplier: 1,
                                   constant: 0),
                NSLayoutConstraint(item: separator,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: contentView,
                                   attribute: .leading,
                                   multiplier: 1,
                                   constant: 0),
                NSLayoutConstraint(item: separator,
                                   attribute: .trailing,
                                   relatedBy: .equal,
                                   toItem: contentView,
                                   attribute: .trailing,
                                   multiplier: 1,
                                   constant: 0),
                NSLayoutConstraint(item: separator,
                                   attribute: .height,
                                   relatedBy: .equal,
                                   toItem: .none,
                                   attribute: .notAnAttribute,
                                   multiplier: 1,
                                   constant: 1)
            ]
            contentView.addConstraints(contentViewContraints)
            self.separator = separator
        }
    }
    
    private func leftStackViewAlignment(leftTitle: String?,
                                        leftSubtitle: String?,
                                        typographyStyle: TypographyStyle,
                                        iconAlignment: UIStackView.Alignment) -> UIStackView.Alignment {
        guard let font = UIFont(family: typographyStyle.attributes.fontFamily,
                                weight: typographyStyle.attributes.fontWeight,
                                size: typographyStyle.attributes.fontSize),
              iconAlignment != .center else {
            return iconAlignment
        }
        
        let heightLimit: CGFloat = 20
        let leftDescriptionHeight = leftSubtitle?.height(withConstrainedWidth: contentView.bounds.width / 1.5, font: font) ?? 0
        
        if leftDescriptionHeight > heightLimit {
            return .top
        } else if leftTitle != nil && leftSubtitle != nil {
            return .top
        }
        return .center
    }
    
    private func configureRadioButton(insertInto stackView: UIStackView, theme: UIFareRadioButtonModel, size: ComponentSize) {
        let width: CGFloat = size == .large ? 24 : 16
        let radioButton = UIFareRadioButton(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: width,
                                                          height: width),
                                            model: theme)
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        radioButton.addTarget(self, action: #selector(radioButtonStatusUpdated), for: .valueChanged)
        radioButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        stackView.addArrangedSubview(radioButton)
        self.radioButton = radioButton
    }
    
    private func configureSwitch(insertInto stackView: UIStackView, model: UIFareSwitchModel) {
        let toggleSwitch = UIFareSwitch(theme: model, frame: CGRect(x: 0, y: 0, width: 48, height: 24))
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitch.addTarget(self, action: #selector(switchStatusUpdated(_:)), for: .valueChanged)
        toggleSwitch.widthAnchor.constraint(equalToConstant: 48).isActive = true
        stackView.addArrangedSubview(toggleSwitch)
        self.toggle = toggleSwitch
    }
    
    private func configureCheckbox(model: UIFareCheckboxModel,
                                   size: ComponentSize,
                                   insertInto stackView: UIStackView) {
        let checkboxWidth: CGFloat = size == .small ? 16 : 24
        let checkBox = UIFareCheckbox(model: model, frame: CGRect(x: 0,
                                                              y: 0,
                                                              width: checkboxWidth,
                                                              height: checkboxWidth))
        
        checkBox.addTarget(self, action: #selector(checkboxStatusUpdated), for: .valueChanged)
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.widthAnchor.constraint(equalToConstant: checkboxWidth).isActive = true
        stackView.addArrangedSubview(checkBox)
        self.checkbox = checkBox
    }
    
    private func configureButton(text: String?, icon: UIImage?, addInto stackview: UIStackView, theme: UIFareCellTheme) {
        let button = TitleLabelSizedButton(type: .custom)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        
        if let text = text {
            button.titleLabel?.font = UIFont(family: theme.buttonTypographyStyle.attributes.fontFamily,
                                             weight: theme.buttonTypographyStyle.attributes.fontWeight,
                                             size: theme.buttonTypographyStyle.attributes.fontSize)
            button.setTitleColor(theme.buttonTextColor, for: [])
            button.setTitle(text, for: [])
            
            let buttonConstraints = [
                NSLayoutConstraint(item: button,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: .none,
                                   attribute: .notAnAttribute,
                                   multiplier: 1,
                                   constant: button.intrinsicContentSize.width)
            ]
            
            button.addConstraints(buttonConstraints)
        } else if let icon = icon {
            button.setImage(icon, for: [])
            button.imageEdgeInsets = UIEdgeInsets(top: -12, left: 12, bottom: -12, right: 4)
            button.imageView?.contentMode = .scaleAspectFit
            
            let buttonConstraints = [
                NSLayoutConstraint(item: button,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: .none,
                                   attribute: .notAnAttribute,
                                   multiplier: 1,
                                   constant: 48)
            ]
            
            button.addConstraints(buttonConstraints)
        }
        stackview.addArrangedSubview(button)
    }
    
    private func configureRightStackIfNeeded(with model: UIFareCellModel) {
        let horizontalStack = UIStackView()
        horizontalStack.distribution = .fill
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = model.theme.actionButtonAlignment
        
        switch model.actionButton {
        case .icon(image: let image):
            configureButton(text: nil, icon: image, addInto: horizontalStack, theme: model.theme)
        case .text(text: let text):
            configureButton(text: text,
                            icon: nil,
                            addInto: horizontalStack,
                            theme: model.theme)
        case .switch:
            configureSwitch(insertInto: horizontalStack,
                            model: model.switchTheme)
            
        default:
            break
        }
        
        if !horizontalStack.arrangedSubviews.isEmpty {
            mainStackView.addArrangedSubview(horizontalStack)
        }
    }
    
    private func configureLeftStackViewIfNeeded(with model: UIFareCellModel) {
        
        let horizontalStackView = UIStackView()
        horizontalStackView.distribution = .fill
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = leftStackViewAlignment(leftTitle: model.leftTitle,
                                                               leftSubtitle: model.leftSubtitle,
                                                               typographyStyle: model.theme.subtitleTypographyStyle,
                                                               iconAlignment: model.theme.iconAlignment)
        
        switch model.actionButton {
        case .checkBox(size: let size):
            configureCheckbox(model: model.checkboxTheme,
                              size: size,
                              insertInto: horizontalStackView)
        case .radio(size: let size):
            configureRadioButton(insertInto: horizontalStackView,
                                 theme: model.radioButtonTheme,
                                 size: size)
            
        default:
            break
        }
        
        if let icon = model.icon {
            switch icon {
            case .bulletNumber(let number):
                configureBulletNumber(number: number,
                                      theme: model.theme,
                                      addInto: horizontalStackView)
                
            case .icon(_, _, let isRounded):
                if isRounded {
                    horizontalStackView.alignment = .center
                }
                configureIcon(icon: icon,
                              theme: model.theme,
                              isRounded: isRounded,
                              addInto: horizontalStackView)
            }
        }
        
        if !horizontalStackView.arrangedSubviews.isEmpty {
            mainStackView.addArrangedSubview(horizontalStackView)
        }
    }
    
    private func configureBulletNumberLayout(bulletLabel: UILabel, containerView: UIView, alignment: UIStackView.Alignment) {
        if alignment == .center {
            NSLayoutConstraint.activate([
                bulletLabel.widthAnchor.constraint(equalToConstant: 20),
                bulletLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 2),
                bulletLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2),
                bulletLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2),
                bulletLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2)
            ])
        } else {
            NSLayoutConstraint.activate([
                bulletLabel.widthAnchor.constraint(equalToConstant: 20),
                bulletLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 2),
                bulletLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
                bulletLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
                bulletLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2)
            ])
        }
    }
    
    private func configureBulletNumber(number: Int, theme: UIFareCellTheme, addInto stackView: UIStackView) {
        let label = OverridableIntrinsicSizeUILabel()
        let containerView = OverridableIntrinsicSizeView()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        containerView.customSize = CGSize(width: 24, height: 24)
        
        label.numberOfLines = 0
        label.text = "\(number)"
        label.font = UIFont(family: theme.bulletTypographyStyle.attributes.fontFamily,
                            weight: theme.bulletTypographyStyle.attributes.fontWeight,
                            size: theme.bulletTypographyStyle.attributes.fontSize)
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 10
        label.layer.borderColor = theme.bulletBorderColor.cgColor
        label.textColor = theme.bulletNumberColor
        label.textAlignment = .center
        label.customSize = CGSize(width: 20, height: 20)
        
        containerView.addSubview(label)
        
        configureBulletNumberLayout(bulletLabel: label,
                                    containerView: containerView,
                                    alignment: stackView.alignment)
        
        stackView.addArrangedSubview(containerView)
    }
    
    private func iconImage(icon: UIImage, stackViewAlignment: UIStackView.Alignment, insets: UIEdgeInsets) -> UIImage {
        if stackViewAlignment == .top {
            return icon.withAlignmentRectInsets(UIEdgeInsets(top: 0,
                                                             left: -3,
                                                             bottom: -6,
                                                             right: -3))
        }
        return icon.withAlignmentRectInsets(insets)
    }
    
    private func configureIcon(icon: UIFareCellIconType,
                               theme: UIFareCellTheme,
                               isRounded: Bool,
                               addInto stackView: UIStackView) {
        
        let imageView = OverridableIntrinsicSizeUIImageView()
        
        imageView.customSize = icon.size
        
        if let tintColor = theme.iconTintColor {
            imageView.image = iconImage(icon: icon.image, stackViewAlignment: stackView.alignment, insets: icon.edgeInsets)
            imageView.tintColor = tintColor
        } else {
            imageView.image = iconImage(icon: icon.image, stackViewAlignment: stackView.alignment, insets: icon.edgeInsets)
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        if isRounded {
            imageView.layer.cornerRadius = icon.size.height / 2
            imageView.clipsToBounds = true
        }
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: icon.size.width)
        ])
        
        stackView.addArrangedSubview(imageView)
    }
    
    private func createLabel(text: String, typographyStyle: TypographyStyle, textColor: UIColor, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.text = text
        label.textColor = textColor
        label.applyTypography(typographyStyle)
        
        return label
    }
    
    private func createLabelsStackView(alignment: NSTextAlignment, stackAlignment: UIStackView.Alignment?) -> UIStackView {
        let stackView = UIStackView()
        
        if alignment == .left {
            stackView.distribution = .fill
            stackView.spacing = 4
            stackView.axis = .vertical
            stackView.alignment = .fill
        } else if alignment == .right {
            stackView.distribution = .fill
            stackView.spacing = 4
            stackView.axis = .vertical
            stackView.alignment = .trailing
        } else {
            stackView.distribution = .fill
            stackView.axis = .horizontal
            stackView.alignment = stackAlignment ?? .fill
        }
        
        return stackView
    }
    
    private func configureLabels(title: String?,
                                 subtitle: String?,
                                 seccondarySubtitle: String?,
                                 tag: (text: String, status: UIFareTagStatus)?,
                                 tagTheme: UIFareTagModel?,
                                 theme: UIFareCellTheme,
                                 isSubtitleAtTop: Bool,
                                 insertInto containerStack: UIStackView,
                                 alignment: NSTextAlignment,
                                 tagAlignment: UIStackView.Alignment? = nil,
                                 previousStackItemCount: Int = 0) {
        let stackView = createLabelsStackView(alignment: alignment, stackAlignment: tagAlignment)
        
        if let title = title {
            let titleLabel = createLabel(text: title,
                                         typographyStyle: theme.titleTypographyStyle,
                                         textColor: alignment == .left ? theme.leftTitleColor : theme.rightTitleColor,
                                         alignment: alignment)
            // We need to set the width constraint when the right side labels to avoid the stackview messing up.
            if alignment == .right {
                titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.width).isActive = true
            }
            
            stackView.addArrangedSubview(titleLabel)
            titleLabel.textAlignment = alignment
        }
        
        if let subtitle = subtitle {
            let subtitleLabel = createLabel(text: subtitle,
                                            typographyStyle: theme.subtitleTypographyStyle,
                                            textColor: alignment == .left ? theme.leftSubtitleColor : theme.rightSubtitleColor,
                                            alignment: alignment)
            if isSubtitleAtTop {
                stackView.insertArrangedSubview(subtitleLabel, at: 0)
            } else {
                stackView.addArrangedSubview(subtitleLabel)
            }
            if alignment == .right {
                subtitleLabel.widthAnchor.constraint(equalToConstant: subtitleLabel.intrinsicContentSize.width).isActive = true
            }
            subtitleLabel.textAlignment = alignment
        }
        
        if let seccondarySubtitle = seccondarySubtitle {
            let seccondarySubtitleLabel = createLabel(text: seccondarySubtitle,
                                                      typographyStyle: theme.seccondarySubtitleTypographyStyle,
                                                      textColor: theme.seccondarySubtitleColor,
                                                      alignment: alignment)
            let fillerView = UIView()
            
            stackView.addArrangedSubview(fillerView)
            stackView.addArrangedSubview(seccondarySubtitleLabel)
            seccondarySubtitleLabel.textAlignment = alignment
        }
        
        if let tag = tag, let tagTheme = tagTheme {
            let tagLabel = UIFareTag()
            tagLabel.text = tag.text
            tagLabel.configure(with: tagTheme)
            stackView.addArrangedSubview(tagLabel)
            tagLabel.widthAnchor.constraint(equalToConstant: tagLabel.intrinsicContentSize.width).isActive = true
        }
        
        if !stackView.arrangedSubviews.isEmpty {
            containerStack.addArrangedSubview(stackView)
        }
        
        // This check is required to move the subtitle label on the right side to the bottom of the stack ()
        if stackView.arrangedSubviews.count == 1  && previousStackItemCount == 2 {
            if title == nil {
                let fillerView = UIView()
                stackView.insertArrangedSubview(fillerView, at: 0)
            }
        }
    }
    
    private func configureCentralStackView(model: UIFareCellModel) {
        if model.leftTitle != nil || model.leftSubtitle != nil || model.leftSeccondarySubtitle != nil {
            configureLabels(title: model.leftTitle,
                            subtitle: model.leftSubtitle,
                            seccondarySubtitle: model.leftSeccondarySubtitle,
                            tag: nil,
                            tagTheme: nil,
                            theme: model.theme,
                            isSubtitleAtTop: model.isSubtitleAtTop,
                            insertInto: mainStackView,
                            alignment: .left)
        }

        if model.rightTitle != nil || model.rightSubtitle != nil {
            let previousStackItemCount = (mainStackView.arrangedSubviews.last as? UIStackView)?.arrangedSubviews.count
            
            configureLabels(title: model.rightTitle,
                            subtitle: model.rightSubtitle,
                            seccondarySubtitle: nil,
                            tag: model.rightTag,
                            tagTheme: model.tagTheme,
                            theme: model.theme,
                            isSubtitleAtTop: model.isSubtitleAtTop,
                            insertInto: mainStackView,
                            alignment: .right,
                            previousStackItemCount: previousStackItemCount ?? 0)
        } else if model.rightTag != nil {
            configureLabels(title: nil,
                            subtitle: nil,
                            seccondarySubtitle: nil,
                            tag: model.rightTag,
                            tagTheme: model.tagTheme,
                            theme: model.theme,
                            isSubtitleAtTop: false,
                            insertInto: mainStackView,
                            alignment: .center,
                            tagAlignment: .top)
        }
    }
    
    @objc private func actionButtonPressed() {
        guard let delegate = delegate, let indexPath = indexPath else {
            return
        }
        delegate.actionChanged(action: .actionButtonPressed(indexPath: indexPath))
    }
    
    @objc private func checkboxStatusUpdated(_ checkbox: UIFareCheckbox) {
        guard let delegate = delegate, let indexPath = indexPath else {
            return
        }
        delegate.actionChanged(action: .checkboxStatusChanged(indexPath: indexPath, isActive: checkbox.isCheckboxSelected))
    }
    
    @objc private func switchStatusUpdated(_ uiSwitch: UISwitch) {
        guard let delegate = delegate, let indexPath = indexPath else {
            return
        }
        delegate.actionChanged(action: .switchStatusChanged(indexPath: indexPath, isActive: uiSwitch.isOn))
    }
    
    @objc private func radioButtonStatusUpdated() {
        guard let delegate = delegate, let indexPath = indexPath else {
            return
        }
        delegate.actionChanged(action: .radioButtonSelected(indexPath: indexPath))
    }
    
    private func configureStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        contentView.addSubview(stackView)
        let constraints = [
                NSLayoutConstraint(item: stackView,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: contentView,
                                   attribute: .top,
                                   multiplier: 1,
                                   constant: 14),
                NSLayoutConstraint(item: stackView,
                                   attribute: .bottom,
                                   relatedBy: .lessThanOrEqual,
                                   toItem: contentView,
                                   attribute: .bottom,
                                   multiplier: 1,
                                   constant: -14),
                NSLayoutConstraint(item: stackView,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: contentView,
                                   attribute: .leading,
                                   multiplier: 1,
                                   constant: 8),
                NSLayoutConstraint(item: stackView,
                                   attribute: .trailing,
                                   relatedBy: .equal,
                                   toItem: contentView,
                                   attribute: .trailing,
                                   multiplier: 1,
                                   constant: -8)
            ]
            
        contentView.addConstraints(constraints)
        return stackView
    }
    
    public static let reuseIdentifier = "DynamicCell"
    
    public static func register(into tableview: UITableView) {
        tableview.register(Self.self, forCellReuseIdentifier: Self.reuseIdentifier)
    }
}
