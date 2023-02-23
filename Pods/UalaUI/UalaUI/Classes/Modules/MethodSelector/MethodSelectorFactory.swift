//
//  MethodSelectorFactory.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 19/05/22.
//

import Foundation

public protocol MethodSelectorFactoryType {
    static func build(with dependencies: MethodSelectorDependenciesType,
                      presenter: MethodSelectorPresenterType) -> UIViewController
}

public struct MethodSelectorFactory: MethodSelectorFactoryType {
    
    public static func build(with dependencies: MethodSelectorDependenciesType,
                             presenter: MethodSelectorPresenterType) -> UIViewController {
        
        return MethodSelectorViewController(with: dependencies, presenter: presenter)
    }
}
