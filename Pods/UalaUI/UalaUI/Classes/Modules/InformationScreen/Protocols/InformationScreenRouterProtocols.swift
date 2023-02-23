//
//  InformationScreenRouterProtocols.swift
//  Alamofire
//
//  Created by Rodrigo Torres on 17/05/2022.
//

public protocol InformationScreenRouterType: AnyObject {
    
    var view: InformationScreenViewType? { get set }
    
    func goToNextView()
    func goToSecondaryAction()
}

public extension InformationScreenRouterType {

    func goToNextView() {
        // Empty default implementation
    }

    func goToSecondaryAction() {
        // Empty default implementation
    }
}
