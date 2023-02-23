//
//  InformationListPresenter.swift
//  Alamofire
//
//  Created by Mario García on 21/10/21.
//

import Foundation
import UalaCore

final class InformationListPresenter {
    
    weak var view: InformationListViewPresenterInterface?
    private var router: InformationListRouterPresenterInterface
    private var interactor: InformationListInteractorPresenterInterface

    init(interactor: InformationListInteractorPresenterInterface,
         router: InformationListRouterPresenterInterface) {
        self.interactor = interactor
        self.router = router
    }
}

extension InformationListPresenter: InformationListPresenterViewInterface {
    var items: [InformationListItem] {
        return interactor.items
    }
    
    var viewTitle: NSAttributedString {
        return interactor.viewTitle
    }
    
    var buttonTitle: String {
        return interactor.buttonTitle
    }
    
    var buttonStyle: ButtonStyle {
        return interactor.buttonStyle
    }
    
    func show() {
        router.show(presenter: self)
    }
    
    func setOutput(view: InformationListViewPresenterInterface) {
        self.view = view
    }
    
    func performButtonAction() {
        router.performAction(action: interactor.action)
    }
    
    func closeButtonAction() {
        router.popBack()
    }
    
    func showError(error: Error) {
        view?.showAlert(with: error)
    }
}
