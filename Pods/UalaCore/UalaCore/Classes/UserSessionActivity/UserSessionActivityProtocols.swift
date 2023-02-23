//
//  UserSessionActivityProtocols.swift
//  UalaHome
//
//  Created by Aldo Martinez on 07/06/22.
//

import Foundation
import PromiseKit

// MARK: - DataManager Protocol
public protocol UserSessionActivityDataManagerProtocol: AnyObject {
    func requestUserProfile() -> Promise<UserSessionActivityResponseDTO>
}

// MARK: - Interactor Protocol
public protocol UserSessionActivityInteractorProtocol: AnyObject {
    var lastSessionDate: String { get }
    func getLastSessionDateStatements()
}

// MARK: - Presenter Protocol
public protocol UserSessionActivityPresenterProtocol: AnyObject {
    var lastSessionDate: String { get }
    func show()
    func didLoad()
    func setOutput(view: UserSessionActivityViewControllerOutput)
    func updateData()
    func showError(error: Error)
}

// MARK: - ViewController Protocol
public protocol UserSessionActivityViewControllerOutput: AnyObject {
    func updateData()
}

// MARK: - Router Protocol
public protocol UserSessionActivityRouterProtocol: AnyObject {
    func show(presenter: UserSessionActivityPresenterProtocol)
    func popBack()
}
