//
//  TutorialModule.swift
//
//  Created by Monserrath Castro on 07/10/21.
//  Copyright © 2021 Ualá. All rights reserved.
//

import Foundation
import UIKit

public class TutorialModule {
    /// Build a view that looks like a tutorial. It has some instructions to indicate how do a procedure.
    /// - Returns: `UIViewController` Object
    public static func build(with tutotialModel: TutorialViewModelType,
                             tutorialType: TutorialType = .tutorial) -> TutorialViewController {
        let interactor: TutorialInteractorProtocol = TutorialInteractor(model: tutotialModel)
        let presenter: TutorialPresenterProtocol = TutorialPresenter()
        let view: TutorialViewController = TutorialViewController(tutorialPresenter: presenter,
                                                                  type: tutorialType)

        view.title = tutotialModel.navigationTitle

        presenter.view = view
        presenter.interactor = interactor

        return view
    }
}
