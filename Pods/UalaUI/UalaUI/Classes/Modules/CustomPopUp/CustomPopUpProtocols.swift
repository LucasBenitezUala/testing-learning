//
//  CustomPopUpProtocols.swift
//  UalaExchange
//
//  Created by Nahuel Herrera on 14/10/2021.
//

import Foundation
import UalaUI

protocol CustomPopUpPresenterProtocol {
    var view: CustomPopUpViewProtocol? { get set }
    var configuration: CustomPopUpConfiguration? { get set }
    func actionPrimaryButton()
    func actionSecundaryButton()
    func viewWillAppear()
}

protocol CustomPopUpViewProtocol {
    var presenterCustomPopUP: CustomPopUpPresenterProtocol? { get set }
    
    func setImage(_ image: UIImage)
    func setTitleText(_ title: NSAttributedString)
    func setDescriptionText(_ description: NSAttributedString)
    func setPrimaryButtonText(text: String, style: ButtonStyle)
    func setSecondaryButton(text: String, style: ButtonStyle)
    func hideImageView(value: Bool)
    func hideTitleLabel(value: Bool)
    func hideDescriptionLabel(value: Bool)
    func hidePrimaryButton(value: Bool)
    func hideSecondaryButton(value: Bool)
}
