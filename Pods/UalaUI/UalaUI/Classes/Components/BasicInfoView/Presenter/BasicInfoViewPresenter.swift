//
// BasicInfoViewPresenter.swift
//
//  Created by Monserrath Castro on 21/04/22.
//  Copyright © 2022 Ualá. All rights reserved.
//

import UalaCore
import UIKit

class BasicInfoViewPresenter: BasicInfoViewPresenterProtocol {
    weak var view: BasicInfoViewProtocol?
    var interactor: BasicInfoViewInteractorProtocol?
}

extension BasicInfoViewPresenter {
    func getViewModel() {
        guard let tutorialModel = interactor?.getViewModel() else { return }
        view?.setTitle(with: tutorialModel.title)
        view?.setDescription(with: tutorialModel.description)
    }

    func getBackgroundColor() -> UIColor? {
        return interactor?.getViewModel()?.backgroundColor
    }

    func getBackgroundImageName() -> String? {
        return interactor?.getViewModel()?.backgroundImage
    }

    func getBackgroundImageBundle() -> StringTables? {
        return interactor?.getViewModel()?.backgroundImageBundle
    }
}
