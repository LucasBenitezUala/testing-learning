//
//  MultisectionInformationProtocols.swift
//  Alamofire
//
//  Created by Aldana Rastrelli on 02/05/2022.
//

import Foundation

// MARK: Presenter -
@objc public protocol MultisectionInformationPresenterProtocol: AnyObject {
    func didClickMainButton(channel: String)
    @objc optional func didClickSecondButton()
}

// MARK: View -
public protocol MultisectionInformationViewProtocol: AnyObject {
    var multisectionPresenter: MultisectionInformationPresenter? { get set }
}

//MARK: Interactor -
public protocol MultisectionInformationInteractorProtocol: AnyObject {
    var presenter: MultisectionInformationPresenter? { get set }
}

//MARK: Router -
public protocol MultisectionInformationRouterProtocol {
    func didPressMainButton()
    func didPressSecondaryButton()
    
    var sectionButtonClosures: [(() -> Void)?] { get }
    
    func pushNextViewController()
    func pushNextViewController(fee: Int, isFree: Bool, totalFee: Double)
    func pushCreatePin(isReprinted: Bool)
    func navigateToFee()
    func pushTokenAmountViewController(channel: String)
}

public protocol MultisectionInformationCellProtocol: UITableViewCell {
    func getMultisectionTableViewCell(tableView: UITableView, indexPath: IndexPath, item: MultisectionInformationViewRow) -> UITableViewCell
}

public extension MultisectionInformationRouterProtocol {
    
    func didPressMainButton() {
        // Empty extension implementation so that classes that implement the Protocol don't have to implement empty funcs every time
    }
    
    func didPressSecondaryButton() {
        // Empty extension implementation so that classes that implement the Protocol don't have to implement empty funcs every time
    }
    
    var sectionButtonClosures: [(() -> Void)?] {
        []
    }
    
    func pushNextViewController(fee: Int, isFree: Bool, totalFee: Double) {
        // Empty extension implementation so that classes that implement the Protocol don't have to implement empty funcs every time
    }
    
    func pushCreatePin(isReprinted: Bool) {
        // Empty extension implementation so that classes that implement the Protocol don't have to implement empty funcs every time
    }
    
    func navigateToFee() {
        // Empty extension implementation so that classes that implement the Protocol don't have to implement empty funcs every time
    }
    
    func pushNextViewController() {
        // Empty extension implementation so that classes that implement the Protocol don't have to implement empty funcs every time
    }
    
    func pushTokenAmountViewController(channel: String) {
        // Empty extension implementation so that classes that implement the Protocol don't have to implement empty funcs every time
    }
}
