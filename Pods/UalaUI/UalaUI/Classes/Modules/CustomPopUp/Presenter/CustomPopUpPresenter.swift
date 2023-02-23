//
//  CustomPopUpPresenter.swift
//  UalaExchange
//
//  Created by Nahuel Herrera on 13/10/2021.
//

import Foundation
import UalaUI

class CustomPopUpPresenter: CustomPopUpPresenterProtocol {
    var configuration: CustomPopUpConfiguration?
    var view: CustomPopUpViewProtocol?
    
    init(configuration: CustomPopUpConfiguration) {
        self.configuration = configuration
    }
    
    private func setPrimaryButton() {
        guard let primaryButtonTitle = configuration?.primaryButtonAction?.title,
              let primaryButtonStyle = configuration?.primaryButtonAction?.style else {
            view?.hidePrimaryButton(value: true)
            return
        }
        view?.setPrimaryButtonText(text: primaryButtonTitle, style: primaryButtonStyle)
    }
    
    private func setSecondaryButton() {
        guard let secondaryButtonTitle = configuration?.secondaryButtonAction?.title,
              let secondaryButtonStyle = configuration?.secondaryButtonAction?.style else {
            view?.hideSecondaryButton(value: true)
            return
        }
        view?.setSecondaryButton(text: secondaryButtonTitle, style: secondaryButtonStyle)
    }
    
    private func setDescriptionLabel() {
        guard let text = configuration?.descriptionText else {
            view?.hideDescriptionLabel(value: true)
            return
        }
        view?.setDescriptionText(text)
    }
    
    private func setTitleLabel() {
        guard let text = configuration?.titleText else {
            view?.hideTitleLabel(value: true)
            return
        }
        view?.setTitleText(text)
    }
    
    private func setImageView() {
        guard let image = configuration?.image else {
            view?.hideImageView(value: true)
            return
        }
        view?.setImage(image)
    }
}

extension CustomPopUpPresenter {
    func viewWillAppear() {
        setPrimaryButton()
        setSecondaryButton()
        setDescriptionLabel()
        setTitleLabel()
        setImageView()
    }
    
    func actionPrimaryButton() {
        guard let baseController = view as? UIViewController else {
            return
        }
        configuration?.primaryButtonAction?.buttonPressed(view: baseController)
    }
    
    func actionSecundaryButton() {
        guard let baseController = view as? UIViewController else {
            return
        }
        configuration?.secondaryButtonAction?.buttonPressed(view: baseController)
    }
}
