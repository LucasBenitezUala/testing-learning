//
//  PhoneCollectorPresenterProtocols.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 22/09/22.
//

public protocol PhoneCollectorPresenterType: AnyObject {
    var view: PhoneCollectorViewType? { get set }
    var router: PhoneCollectorRouterType? { get set }
    var interactor: PhoneCollectorInteractorType? { get set }
    var lenghtPhone: Int { get set }

    func viewDidLoad()
    func didTapPrimaryAction()
    func didCollectPhone(value: String)
    func didUpdateError()
}

public extension PhoneCollectorPresenterType {

    func viewDidLoad() {
        // Empty Default implementation
    }

    func didTapPrimaryAction() {
        // Empty Default implementation
    }

    func didCollectPhone(value: String) {
        // Empty Default implementation
    }

    func didUpdateError() {
        // Empty Default implementation
    }
}
