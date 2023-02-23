//
//  MFAScreenConstantsType.swift
//  UalaUI
//
//  Created by Rodrigo Torres on 20/05/2022.
//

public protocol MFAScreenConstantsType {
    var titleStyle: LabelStyle { get }
    var subtitlenStyle: LabelStyle { get }
    var errorLabelStyle: LabelStyle { get }
    var reSendButtonStyle: ButtonStyle? { get }
    var bottomLabelStyle: LabelStyle { get }
    var bottomButtonStyle: ButtonStyle { get }
}
