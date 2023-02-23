//
//  SurveyRouter.swift
//  Pods
//
//  Created by Miguel Jasso on 06/10/21.
//  
//

import UIKit
import UalaCore
import UalaUI

class SurveyRouter: SurveyRouterProtocol {
    
    weak var viewController: BaseViewController?

    func present(view: UIViewController) {
        viewController?.navigationController?.pushViewController(view, animated: false)
    }
}
