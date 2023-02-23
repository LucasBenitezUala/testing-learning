//
//  InformationListProtocols.swift
//  UalaUI
//
//  Created by Mario García on 21/10/21.
//

import Foundation

// MARK: - Presenter Protocol
protocol InformationListPresenterViewInterface: AnyObject {
    var items: [InformationListItem] { get }
    var viewTitle: NSAttributedString { get }
    var buttonTitle: String { get }
    var buttonStyle: ButtonStyle { get }
    func show()
    func setOutput(view: InformationListViewPresenterInterface)
    func performButtonAction()
    func closeButtonAction()
    func showError(error: Error)
}

// MARK: - Interactor Protocol
protocol InformationListInteractorPresenterInterface: AnyObject {
    var items: [InformationListItem] { get }
    var viewTitle: NSAttributedString { get }
    var buttonTitle: String { get }
    var buttonStyle: ButtonStyle { get }
    var action: InformationViewAction? { get }
}

// MARK: - Router Protocol
protocol InformationListRouterPresenterInterface: AnyObject {
    func show(presenter: InformationListPresenterViewInterface)
    func performAction(action: InformationViewAction?)
    func popBack()
}

// MARK: - ViewController Protocol
protocol InformationListViewPresenterInterface: BaseView {
    func updateData()
}
