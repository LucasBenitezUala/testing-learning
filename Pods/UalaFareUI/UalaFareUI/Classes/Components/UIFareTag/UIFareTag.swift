//
//  LabelTag.swift
//  UalaFareUI
//
//  Created by Luis Perez on 19/07/22.
//

import UIKit

@IBDesignable
public final class UIFareTag: UILabel {
    
    @IBInspectable
    public var status: String = "new" {
        didSet {
            self.model = MainThemeManager.shared.tagThemedModel(status: UIFareTagStatus(rawValue: status) ?? .new, size: .small)
            configureTheme()
        }
    }
    
    @IBInspectable
    public var size: String? {
        didSet {
            guard let status = UIFareTagStatus(rawValue: status),
                  let stringSize = size,
                  let size = ComponentSize(rawValue: stringSize) else {
                return
            }
            self.model = MainThemeManager.shared.tagThemedModel(status: status,
                                                                size: size)
            configureTheme()
        }
    }
    
    private var model: UIFareTagModel = MainThemeManager.shared.tagThemedModel(status: .new, size: .small)
    
    public init(model: UIFareTagModel, frame: CGRect = .zero) {
        self.model = model
        super.init(frame: frame)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureTheme()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTheme()
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: model.edgeInsets))
        configureTheme()
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        var adjSize = super.sizeThatFits(size)
        adjSize.width += model.edgeInsets.left + model.edgeInsets.right
        adjSize.height += model.edgeInsets.top + model.edgeInsets.bottom

        return adjSize
    }

    public override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += model.edgeInsets.left + model.edgeInsets.right
        contentSize.height += model.edgeInsets.top + model.edgeInsets.bottom

        return contentSize
    }
    
    public func configure(with model: UIFareTagModel) {
        self.model = model
        configureTheme()
    }
    
    private func configureTheme() {
        applyTypography(model.typographyStyle)
        backgroundColor = model.backgroundColor
        textColor = model.textColor
        layer.cornerRadius = model.cornerRadius
        layer.masksToBounds = true
        invalidateIntrinsicContentSize()
    }
}
