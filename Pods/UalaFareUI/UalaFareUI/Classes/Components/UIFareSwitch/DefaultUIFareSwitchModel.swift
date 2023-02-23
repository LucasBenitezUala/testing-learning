//
//  DefaultUIFareSwitchModel.swift
//  UalaFareUI
//
//  Created by Luis Perez on 01/09/22.
//

import UIKit

struct DefaultUIFareSwitchModel: UIFareSwitchModel {
    public var onColor: UIColor
    public var offColor: UIColor
    public var disabledOnColor: UIColor
    public var disabledOffColor: UIColor
    public var thumbColor: UIColor
    
    public init(onColor: UIColor,
                offColor: UIColor,
                disabledOnColor: UIColor,
                disabledOffColor: UIColor,
                thumbColor: UIColor) {
        self.onColor = onColor
        self.offColor = offColor
        self.disabledOnColor = disabledOnColor
        self.disabledOffColor = disabledOffColor
        self.thumbColor = thumbColor
    }
}
