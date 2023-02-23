//
//  TutorialInteractor.swift
//
//  Created by Monserrath Castro on 07/10/21.
//  Copyright © 2021 Ualá. All rights reserved.
//

import UalaUtils

class TutorialInteractor: TutorialInteractorProtocol {
    weak var presenter: TutorialPresenterProtocol?
    private var model: TutorialViewModelType

    init(model: TutorialViewModelType) {
        self.model = model
    }
}

extension TutorialInteractor {
    func getInstruction(at index: Int) -> InstructionDataType? {
        return model.instructions[safe: index]
    }
    func getNumberOfInstructions() -> Int {
        return model.instructions.count
    }

    func getViewModel() -> TutorialViewModelType? {
        return model
    }
}
