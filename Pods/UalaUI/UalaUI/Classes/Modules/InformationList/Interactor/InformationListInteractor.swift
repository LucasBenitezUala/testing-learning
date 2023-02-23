//
//  InformationListInteractor.swift
//  Alamofire
//
//  Created by Mario García on 21/10/21.
//

import Foundation
import PromiseKit

final class InformationListInteractor {
    
    let input: InformationListModelType
    
    init(input: InformationListModelType) {
        self.input = input
    }
}

extension InformationListInteractor: InformationListInteractorPresenterInterface {
    var items: [InformationListItem] {
        return input.items
    }
    
    var viewTitle: NSAttributedString {
        return input.title
    }
    
    var buttonTitle: String {
        return input.buttonAction?.actionTitle ?? ""
    }
    
    var buttonStyle: ButtonStyle {
        return input.buttonStyle
    }
    
    var action: InformationViewAction? {
        return input.buttonAction
    }
}
