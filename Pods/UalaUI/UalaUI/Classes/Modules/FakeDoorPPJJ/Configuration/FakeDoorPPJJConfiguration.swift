//
//  FakeDoorPPJJConfiguration.swift
//  Pods
//
//  Created Pedro Romero on 12/11/21.
//  Copyright © 2021 Ualá. All rights reserved.

import UIKit

public struct FakeDoorPPJJConfigurator {
    
    public static func build(_ title: String? = nil, isEmbedInView: Bool = false) -> BaseViewController {
        let view: PlaceholderView = PlaceholderView.loadXib()
        view.isEmbedInView = isEmbedInView
        let router = FakeDoorPPJJRouter()
        let presenter = FakeDoorPPJJPresenter(interface: view, router: router, title: title)
        
        view.placeholderPresenter = presenter
        router.viewController = view
        
        return view
    }
}
