//
//  CustomPopUpConfiguration.swift
//  UalaExchange
//
//  Created by Nahuel Herrera on 13/10/2021.
//

import Foundation
import UalaUI

public class CustomPopUpConfiguration {
    var navigationView: UINavigationController?
    let image: UIImage?
    let titleText: NSAttributedString?
    let descriptionText: NSAttributedString?
    let primaryButtonAction: FeedbackViewAction?
    let secondaryButtonAction: FeedbackViewAction?
    
    public init(image: UIImage?, titleText: NSAttributedString?, descriptionText: NSAttributedString?, primaryButtonAction: FeedbackViewAction?, secondaryButtonAction: FeedbackViewAction?) {
        self.image = image
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.primaryButtonAction = primaryButtonAction
        self.secondaryButtonAction = secondaryButtonAction
    }
}
