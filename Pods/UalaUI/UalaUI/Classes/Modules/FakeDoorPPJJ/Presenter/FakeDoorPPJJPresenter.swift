//
//  FakeDoorPPJJPresenter.swift
//  Pods
//
//  Created Pedro Romero on 12/11/21.
//  Copyright © 2021 Ualá. All rights reserved.

import UIKit
import UalaCore

class FakeDoorPPJJPresenter: FakeDoorPPJJPresenterProtocol {

    weak private var view: PlaceholderViewProtocol?
    private let router: FakeDoorPPJJWireframeProtocol
    private let title: String?

    init(interface: PlaceholderViewProtocol, router: FakeDoorPPJJWireframeProtocol, title: String?) {
        self.view = interface
        self.router = router
        self.title = title
    }
    
    private func configure() {
        view?.setTitle(translate("FAKE_DOOR_TITLE", from: .Common))
        view?.setsubtitle(translate("FAKE_DOOR_SUBTITLE", from: .Common))
        view?.setButton(translate("FAKE_DOOR_PRIMARY_BUTTON", from: .Common), UalaStyle.buttons.standardFilledLight)
        let image = BundleImage(bundle: .Common, named: "error_heart")
        view?.setImage(image, type: .square)
        view?.hidePrimaryButton(false)
        view?.hideSecondaryButton(true)
        if let title = title {
            view?.setTitleView(title)
        }
    }
}

extension FakeDoorPPJJPresenter: PlaceholderPresenterProtocol {
    func viewDidLoad() {
        configure()
    }
    
    func didClickButton() {
        router.goToHome()
    }
}
