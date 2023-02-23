//
//  BasicInfoViewModuleProtocols.swift
//
//  Created by Monserrath Castro on 21/04/22.
//  Copyright © 2022 Ualá. All rights reserved.
//

import UalaCore
import UIKit

public protocol BasicInfoViewProtocol: BaseViewController {
    var basicInfoViewPresenter: BasicInfoViewPresenterProtocol? { get set }

    func setTitle(with text: String?)
    func setDescription(with text: String?)
}

public protocol BasicInfoViewPresenterProtocol: Presenter {
    var view: BasicInfoViewProtocol? { get set }
    var interactor: BasicInfoViewInteractorProtocol? { get set }

    func getViewModel()
    func getBackgroundColor() -> UIColor?
    func getBackgroundImageName() -> String?
    func getBackgroundImageBundle() -> StringTables?
}

public protocol BasicInfoViewInteractorProtocol: AnyObject {
    var presenter: BasicInfoViewPresenterProtocol? { get set }
    
    func getViewModel() -> BasicInfoViewModelType?
}
