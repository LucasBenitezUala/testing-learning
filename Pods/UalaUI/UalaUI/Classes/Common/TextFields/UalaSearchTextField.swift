//
//  UalaSearchTextField.swift
//  Uala
//
//  Created by Developer on 9/10/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import UIKit
import UalaCore

@IBDesignable
open class UalaSearchTextField: UITextField {

    var clearButtonImage: UIImage?
    var onClearButtonTapped: (() -> Void)?
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {}
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func configure(style: UalaSearchTextFieldStyle = .defaultStyle) {
        self.placeholder = translate("Buscar")
        self.backgroundColor = style.backGroudColor
        self.borderStyle = .none
        self.textColor = style.textColor
        self.font = UIFont.regular(size: style.fontSize)
        self.tintColor = style.tintColor
        
        let attributedPlaceHolder = NSAttributedString(
            string: self.placeholder ?? "",
            attributes: [
                .font: UIFont.regular(size: 17),
                .foregroundColor: style.textColor.withAlphaComponent(0.6)
            ]
        )
        self.attributedPlaceholder = attributedPlaceHolder
        
        let leftContentView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: self.frame.height))
        self.leftView = leftContentView
        self.leftViewMode = .always
        
        let searchImageView = UIImageView(image: BundleImage(bundle: .Common, named: style.leftImageName))
        searchImageView.center = leftContentView.center
        leftContentView.addSubview(searchImageView)
        
        self.autocapitalizationType = .words
        self.autocorrectionType = .no
        self.returnKeyType = .search
        self.enablesReturnKeyAutomatically = true
        self.clearButtonMode = .whileEditing
        layer.cornerRadius = cornerRadius
        clipsToBounds = cornerRadius > 0
        modifyClearButtonWithImage(image: BundleImage(bundle: .Common, named: "field_clear_icon") ?? UIImage())
        
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clearField(sender:)))
        gesture.numberOfTapsRequired = 1
        rightView?.addGestureRecognizer(gesture)
    }
    
    @objc func clearField(sender: AnyObject) {
        text = ""
        onClearButtonTapped?()
    }
}

public struct UalaSearchTextFieldStyle {
    let tintColor: UIColor
    let backGroudColor: UIColor
    let textColor: UIColor
    let leftImageName: String
    let fontSize: CGFloat
    let clearButtonTintColor: UIColor
}
public extension UalaSearchTextFieldStyle {
    static var defaultStyle: UalaSearchTextFieldStyle {
        return UalaSearchTextFieldStyle(tintColor: UalaStyle.colors.fareTextMainColor,
                                        backGroudColor: UIColor.white,
                                        textColor: UalaStyle.colors.fareTextMainColor,
                                        leftImageName: "searchSmall_blue",
                                        fontSize: 17,
                                        clearButtonTintColor: UalaStyle.colors.grey60)
    }

    static var grey: UalaSearchTextFieldStyle {
        return UalaSearchTextFieldStyle(tintColor: UalaStyle.colors.grey60,
                                        backGroudColor: UalaStyle.colors.paleGrey,
                                        textColor: UalaStyle.colors.grey60,
                                        leftImageName: "searchSmall_grey",
                                        fontSize: 15,
                                        clearButtonTintColor: UalaStyle.colors.grey60)
    }
}
