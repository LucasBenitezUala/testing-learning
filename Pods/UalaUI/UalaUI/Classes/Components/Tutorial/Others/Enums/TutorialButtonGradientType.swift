//
//  TutorialButtonGradientType.swift
//  UalaUI
//
//  Created by Alan Valencia on 16/03/22.
//

import UIKit

public enum TutorialButtonGradientType {
    case regular(startColor: UIColor, endColor: UIColor)
    case none
    
    public static var defaultValue: TutorialButtonGradientType {
        return .regular(startColor: UIColor.white.withAlphaComponent(0), endColor: UIColor.white)
    }
}
