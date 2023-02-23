//
//  MethodSelectorRouterProtocols.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 19/05/22.
//

public protocol MethodSelectorRouterType {
    var view: UIViewController? { get set }

    func goToNextScreen(with method: String)
}

public extension MethodSelectorRouterType {

    func goToNextScreen(with method: String) {
        // Empty default implementation
    }
}
