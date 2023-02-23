//
//  AlertFieldView.swift
//  Uala
//
//  Created by Alejandro Zalazar on 26/07/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

public class AlertFieldView: BaseFieldView {

    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var alertView: UIView!
    @IBOutlet private weak var messageLabel: UILabel!
    private var style: AlertFieldStyle
    
    var message: String
    
    public init(message: String, style: AlertFieldStyle = .errorRed) {
        self.message = message
        self.style = style
        super.init(frame: .zero)
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        messageLabel.text = message
        messageLabel.textColor = style.textColor
        alertView.backgroundColor = style.backgroundColor
        iconImage.image = style.image
        alertView.cornerRadius(radius: style.cornerRadius)
        messageLabel.font = style.font
    }
}
