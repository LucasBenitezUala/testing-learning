//
//  LoginModule.swift
//  UalaLabs_Example
//
//  Created by Francisco Javier Saldivar Rubio on 21/10/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UalaCore
import UalaAuth

public struct LoginModule {
    public static func buildView() -> UIViewController {
        let router = LoginRouter()
        let events = LoginEvents()
        let loginController: UIViewController = LoginDemoFactory(presenterEvents: events, router: router).build()
        return loginController
    }
}
