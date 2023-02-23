//
//  BasicInfoViewInteractor.swift
//
//  Created by Monserrath Castro on 21/04/22.
//  Copyright © 2022 Ualá. All rights reserved.
//

class BasicInfoViewInteractor: BasicInfoViewInteractorProtocol {
    weak var presenter: BasicInfoViewPresenterProtocol?
    private var model: BasicInfoViewModelType

    init(model: BasicInfoViewModelType) {
        self.model = model
    }
}

extension BasicInfoViewInteractor {
    func getViewModel() -> BasicInfoViewModelType? {
        return model
    }
}
