//
//  BasicInfoViewModule.swift
//
//  Created by Monserrath Castro on 21/04/22.
//  Copyright © 2022 Ualá. All rights reserved.
//

import Foundation
import UIKit

public class BasicInfoViewModule {
    public static func build(with baciscInfoModel: BasicInfoViewModelType) -> BasicInfoViewController {
        let interactor: BasicInfoViewInteractorProtocol = BasicInfoViewInteractor(model: baciscInfoModel)
        let presenter: BasicInfoViewPresenterProtocol = BasicInfoViewPresenter()
        let view = BasicInfoViewController(basicInfoViewPresenter: presenter)

        view.title = baciscInfoModel.navigationTitle
        
        presenter.view = view
        presenter.interactor = interactor

        return view
    }
}
