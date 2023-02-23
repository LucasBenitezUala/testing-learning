//
//  InformationScreenControllerType.swift
//  UalaUI
//
//  Created by Rodrigo Torres on 17/05/2022.
//

import Foundation

public protocol InformationScreenDependenciesType {
    var parameters: InformationScreenParametersType { get }
    var uiConstants: InformationScreenConstantsType { get }
}
