//
//  TutorialModuleProtocols.swift
//
//  Created by Monserrath Castro on 07/10/21.
//  Copyright © 2021 Ualá. All rights reserved.
//

public protocol TutorialViewProtocol: BaseViewController {
    var tutorialPresenter: TutorialPresenterProtocol? { get set }

    func addBackAction()
    func setTitle(with text: String?)
    func setSubtitle(with text: String?)
    func setPrimaryActionTitle(with text: String?)
    func reloadInstructions()
    func removePrimaryActionButton()
}

public protocol TutorialPresenterProtocol: Presenter {
    var view: TutorialViewProtocol? { get set }
    var interactor: TutorialInteractorProtocol? { get set }

    func backButtonPressed()
    func getInstruction(at index: Int) -> InstructionDataType?
    func getNumberOfInstructions() -> Int
    func getViewModel()
    func getCellStyle() -> TutorialCellStyle
    func getBackgroundColor() -> UIColor?
    func getGradientType() -> TutorialButtonGradientType
    func primaryActionButtonPressed()
    func getConfiguration() -> TutorialCellConfiguration?
}

public protocol TutorialInteractorProtocol: AnyObject {
    var presenter: TutorialPresenterProtocol? { get set }

    func getInstruction(at index: Int) -> InstructionDataType?
    func getNumberOfInstructions() -> Int
    func getViewModel() -> TutorialViewModelType?
}
