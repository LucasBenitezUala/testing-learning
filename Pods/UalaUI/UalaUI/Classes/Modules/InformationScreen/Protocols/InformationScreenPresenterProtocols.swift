//
//  InformationScreenPresenterProtocols.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 22/09/22.
//

public protocol InformationScreenPresenterType: AnyObject {
    var view: InformationScreenViewType? { get set }
    var router: InformationScreenRouterType? { get set }
    
    func viewDidLoad()
    func didTapPrimaryAction()
    func didTapDescription()
    func didTapBackButton()
    func didTapSecondaryAction()
}

public extension InformationScreenPresenterType {

    func viewDidLoad() {
        // Empty default implementation
    }

    func didTapPrimaryAction() {
        // Empty default implementation
    }

    func didTapDescription() {
        // Empty default implementation
    }

    func didTapBackButton() {
        // Empty default implementation
    }

    func didTapSecondaryAction() {
        // Empty default implementation
    }
}
