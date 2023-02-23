//
//  MultisectionInformationPresenter.swift
//  UalaUI
//
//  Created by Aldana Rastrelli on 02/05/2022.
//

import Foundation

open class MultisectionInformationPresenter: MultisectionInformationPresenterProtocol {
    
    public weak var view: MultisectionInformationViewProtocol?
    public var viewModel: MultisectionInformationViewModel?
    public var router: MultisectionInformationRouterProtocol?
    public var interactor: MultisectionInformationInteractorProtocol?
    
    public init() {
        // needed for initialization
    }
    
    func getNumberOfSections() -> Int {
        guard let count = viewModel?.sections.count else {
            return 0
        }
        return count
    }
    
    func numberOfRowsIn(section: Int) -> Int {
        
        guard let selectedSection = viewModel?.sections[section], let rowsInSection: [MultisectionInformationViewRow]? = selectedSection.rows, let count = rowsInSection?.count else {
            return 0
        }
        return count
    }
    
    func itemsInSection(_ section: Int) -> [MultisectionInformationViewRow] {
        guard let selectedSection = viewModel?.sections[section] else {
            return []
        }
        return selectedSection.rows
    }
    
    func getModelTitle() -> String {
        guard let title = viewModel?.title else {
            return ""
        }
        return title
    }
    
    open func didClickMainButton(channel: String) {
        // Override implementation
    }
    
    open func didClickSecondButton() {
        // Override implementation
    }
}
