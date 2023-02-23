//
//  CustomPopUpModule.swift
//  UalaExchange
//
//  Created by Nahuel Herrera on 13/10/2021.
//

import Foundation
import UalaUI

public class CustomPopUp {
    public static func present(by navigation: UINavigationController?, configuration: CustomPopUpConfiguration) {
        var presenter: CustomPopUpPresenterProtocol = CustomPopUpPresenter(configuration: configuration)
        let view: CustomPopUpViewController = CustomPopUpViewController(presenter: presenter)
        
        configuration.navigationView = navigation
        presenter.view = view
        view.modalPresentationStyle = .custom
        navigation?.present(view, animated: true, completion: nil)
    }
}
