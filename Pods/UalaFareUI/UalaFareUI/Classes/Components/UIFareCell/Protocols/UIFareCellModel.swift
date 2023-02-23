//
//  DynamicInformationTableViewCellModel.swift
//  UalaFareUI
//
//  Created by Luis Perez on 27/07/22.
//

public protocol UIFareCellModel {
    typealias Tag = (text: String, status: UIFareTagStatus)
    var leftTitle: String? { get }
    var leftSubtitle: String? { get }
    var leftSeccondarySubtitle: String? { get }
    var icon: UIFareCellIconType? { get }
    var rightTitle: String? { get }
    var rightSubtitle: String? { get }
    var rightTag: Tag? { get }
    var shouldAddDivider: Bool { get }
    var actionButton: UIFareCellButtonType? { get }
    var pressedCellBackgroundColor: UIColor { get }
    var theme: UIFareCellTheme { get }
    var tagTheme: UIFareTagModel { get }
    var switchTheme: UIFareSwitchModel { get }
    var radioButtonTheme: UIFareRadioButtonModel { get }
    var checkboxTheme: UIFareCheckboxModel { get }
    var isSubtitleAtTop: Bool { get }
}
