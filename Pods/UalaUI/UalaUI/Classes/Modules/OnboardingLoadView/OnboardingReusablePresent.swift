//
//  OnboardingReusablePresent.swift
//  UalaUI
//
//  Created by Juan Emmanuel Cepeda on 10/03/21.
//

import Foundation
import UalaUtils
final class OnboardingReusablePresent {
    
    weak var view: OnboardingReusableViewProtocol?

    init(interface: OnboardingReusableViewProtocol) {
        self.view = interface
    }
}

extension OnboardingReusablePresent: OnboardingReusablePresenterProtocol {
    func didClickButton() {
        LogManager.shared.debug(info: "Implement router here to push next VC ")
    }
    
    func secondaryClickButton() {
        LogManager.shared.debug(info: "Implement router here to push next VC ")
    }
}
