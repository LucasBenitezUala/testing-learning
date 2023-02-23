//
//  PhoneCollectorRouterProtocols.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 22/09/22.
//

public protocol PhoneCollectorRouterType: AnyObject {
    var view: PhoneCollectorViewType? { get set }

    func goTo()
}

public extension PhoneCollectorRouterType {

    func goTo() {
        // Empty Default implementation
    }
}
