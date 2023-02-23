//
// TutorialPresenter.swift
//
//  Created by Monserrath Castro on 07/10/21.
//  Copyright © 2021 Ualá. All rights reserved.
//

class TutorialPresenter: TutorialPresenterProtocol {
    weak var view: TutorialViewProtocol?
    var interactor: TutorialInteractorProtocol?
}

extension TutorialPresenter {
    func backButtonPressed() {
        guard let tutorialModel = interactor?.getViewModel(),
              let backAction = tutorialModel.backAction else { return }
        backAction.delegate?.tutorialView(tutorialType: tutorialModel.type, actionExecuted: backAction.type)
        func getInstruction(at index: Int) -> InstructionDataType? {
            return interactor?.getInstruction(at: index)
        }
    }

    func getInstruction(at index: Int) -> InstructionDataType? {
        return interactor?.getInstruction(at: index)
    }

    func getNumberOfInstructions() -> Int {
        return interactor?.getNumberOfInstructions() ?? 0
    }

    func getViewModel() {
        guard let tutorialModel = interactor?.getViewModel() else { return }
        view?.setTitle(with: tutorialModel.title)
        view?.setSubtitle(with: tutorialModel.subtitle)

        if tutorialModel.backAction != nil {
            view?.addBackAction()
        }

        if let primaryAction = tutorialModel.primaryAction {
            view?.setPrimaryActionTitle(with: primaryAction.title)
        }

        view?.reloadInstructions()
    }
    
    func getCellStyle() -> TutorialCellStyle {
        guard let tutorialModel = interactor?.getViewModel() else { return .plain }
        return tutorialModel.cellStyle
    }
    
    func getBackgroundColor() -> UIColor? {
        return interactor?.getViewModel()?.backgroundColor
    }
    
    func getGradientType() -> TutorialButtonGradientType {
        guard let tutorialModel = interactor?.getViewModel() else { return .defaultValue }
        return tutorialModel.buttonGradient
    }
    
    func getConfiguration() -> TutorialCellConfiguration? {
        return interactor?.getViewModel()?.configuration
    }

    func primaryActionButtonPressed() {
        guard let tutorialModel = interactor?.getViewModel(),
              let primaryAction = tutorialModel.primaryAction else { return }
        primaryAction.delegate?.tutorialView(tutorialType: tutorialModel.type, actionExecuted: primaryAction.type)
    }
}
