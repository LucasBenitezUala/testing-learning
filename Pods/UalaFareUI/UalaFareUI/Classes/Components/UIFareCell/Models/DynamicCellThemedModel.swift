//
//  DynamicInformationCellThemedModel.swift
//  UalaFareUI
//
//  Created by Luis Perez on 27/07/22.
//

import UIKit

struct DynamicCellThemedModel: UIFareCellModel {
    var leftTitle: String?
    var leftSubtitle: String?
    var leftSeccondarySubtitle: String?
    var icon: UIFareCellIconType?
    var rightTitle: String?
    var rightSubtitle: String?
    var rightTag: Tag?
    var shouldAddDivider: Bool
    var actionButton: UIFareCellButtonType?
    var pressedCellBackgroundColor: UIColor
    var theme: UIFareCellTheme
    var tagTheme: UIFareTagModel
    var switchTheme: UIFareSwitchModel
    var radioButtonTheme: UIFareRadioButtonModel
    var checkboxTheme: UIFareCheckboxModel
    var isSubtitleAtTop: Bool
}
