//
//  MFAScreenDependeciesType.swift
//  UalaUI
//
//  Created by Rodrigo Torres on 20/05/2022.
//

import Foundation

public protocol MFAScreenViewDependenciesType {
    var parameters: MFAScreenParametersType { get }
    var constants: MFAScreenConstantsType { get }
    var buttons: MFAButtonsType { get }
    var pinCode: PinCodeTextType { get }
    var placeholder: LabelTextType? { get }
}
