//
//  PasswordCollectorPresenterProtocols.swift
//  UalaUI
//
//  Created by Agustina Ardisana on 31/10/2022.
//

public protocol PasswordCollectorPresenterType: AnyObject {
    var view: PasswordCollectorViewType? { get set }
    var interactor: PasswordCollectorInteractorType? { get set }
    var router: PasswordCollectorRouterType? { get set }
    
    func viewDidLoad()
    func didTapPrimaryAction()
    func didCollectPassword(value: String)
    func didUpdateError()
}

public extension PasswordCollectorPresenterType {
    func viewDidLoad() {
        // Empty Default implementation
    }
}
