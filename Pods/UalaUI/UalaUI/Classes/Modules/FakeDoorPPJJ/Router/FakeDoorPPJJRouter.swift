//
//  FakeDoorPPJJRouter.swift
//  Pods
//
//  Created Pedro Romero on 12/11/21.
//  Copyright © 2021 Ualá. All rights reserved.

import UIKit

class FakeDoorPPJJRouter {
    weak var viewController: UIViewController?
}

extension FakeDoorPPJJRouter: FakeDoorPPJJWireframeProtocol {
    func goToHome() {
        viewController?.navigationController?.popViewController(animated: false)
        guard let deepLinkHome = URL(string: "uala://www.uala.com.ar/home") else { return }
        UIApplication.shared.open(deepLinkHome)
    }
}
