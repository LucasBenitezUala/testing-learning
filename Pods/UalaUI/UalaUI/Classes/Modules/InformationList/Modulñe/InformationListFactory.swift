//
//  InformationListFactory.swift
//  Alamofire
//
//  Created by Mario García on 21/10/21.
//

import Foundation

public final class InformationListFactory {
    
    private var presenter: InformationListPresenter
    
    public init(input: InformationListModelType, baseController: BaseViewController, isPresent: Bool) {
        let router = InformationListRouter(baseController: baseController, isPresent: isPresent)
        let interactor = InformationListInteractor(input: input)
                
        presenter = InformationListPresenter(interactor: interactor,
                                             router: router)
    }
    
    public func show() {
        presenter.show()
    }
}
