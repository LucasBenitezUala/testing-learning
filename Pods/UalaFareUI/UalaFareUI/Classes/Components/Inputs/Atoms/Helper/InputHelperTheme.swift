//
//  InputHelperTheme.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 21/07/2022.
//

import UIKit

public protocol InputHelperTheme {
    var helperLabelTypography: TypographyStyle { get }
    var informationConfiguration: InputHelperConfiguration { get }
    var successConfiguration: InputHelperConfiguration { get }
    var warningConfiguration: InputHelperConfiguration { get }
    var errorConfiguration: InputHelperConfiguration { get }
    var standardConfiguration: InputHelperConfiguration { get }
    var disabledConfiguration: InputHelperConfiguration { get }
}

public protocol InputHelperConfiguration {
    var icon: UIImage? { get }
    var tint: UIColor { get }
}
