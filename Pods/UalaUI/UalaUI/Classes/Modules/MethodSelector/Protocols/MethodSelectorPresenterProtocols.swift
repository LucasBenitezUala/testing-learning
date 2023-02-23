//
//  MethodSelectorPresenterProtocols.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 22/09/22.
//

public protocol MethodSelectorPresenterType {
    var view: UIViewController? { get set }

    var items: [MethodSelectorCellModelType] { get }
    var router: MethodSelectorRouterType { get set }

    func selected(_ item: MethodSelectorCellModelType)
}

public extension MethodSelectorPresenterType {

    func selected(_ item: MethodSelectorCellModelType) {
        //Empty default implementation
    }
}
