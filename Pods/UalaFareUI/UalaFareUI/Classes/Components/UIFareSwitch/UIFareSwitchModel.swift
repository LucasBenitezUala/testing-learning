//
//  UIFareSwitchModel.swift
//  UalaDSDemo
//
//  Created by Luis Perez on 04/07/22.
//
import UIKit

public protocol UIFareSwitchModel {
    var onColor: UIColor { get }
    var offColor: UIColor { get }
    var disabledOnColor: UIColor { get }
    var disabledOffColor: UIColor { get }
    var thumbColor: UIColor { get }
}
