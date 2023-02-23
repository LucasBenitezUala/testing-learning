//
//  PinCodeTextType.swift
//  UalaUI
//
//  Created by Rodrigo Torres on 20/05/2022.
//

import Foundation

public protocol PinCodeTextType {
    var pinCodeColorBoxNormal: UIColor { get }
    var pinCodeColorBoxError: UIColor { get }
    var pinCodeTextColorNormal: UIColor { get }
    var pinCodeTextColorError: UIColor { get }
    var pinCodeTextLenght: Int { get }
    var pinCodeBorderRadiusBox: CGFloat { get }
    var pinCodeSpacing: CGFloat { get }
    var pinCodeBorderColor: UIColor { get }
    var pinCodeBorderWidth: CGFloat { get }
}
