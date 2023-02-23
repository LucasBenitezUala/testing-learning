//
//  MFAScreenRouterProtocols.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 22/09/22.
//

public protocol MFAScreenRouterType: AnyObject {
    var view: MFAScreenControllerType? { get set }
    
    func goToNextView()
    func goToErrorView()
}

public extension MFAScreenRouterType {

    func goToNextView() {
        // Empty default implementation
    }

    func goToErrorView() {
        // Empty default implementation
    }

}
