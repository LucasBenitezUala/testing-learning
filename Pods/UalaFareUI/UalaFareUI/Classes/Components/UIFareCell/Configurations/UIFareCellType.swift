//
//  DynamicInfoCellType.swift
//  UalaFareUI
//
//  Created by Luis Perez on 29/07/22.
//

public enum UIFareCellType {
    case simpleNonActionable(leftTitle: String?,
                             leftSubtitle: String?,
                             rightTitle: String?,
                             rightSubtitle: String?,
                             leftIndicator: UIFareCellIndicator?,
                             size: UIFareCellSize,
                             swapTitleWithSubtitle: Bool,
                             showSeparator: Bool = true)
    
    case simpleActionable(leftTitle: String?,
                          leftSubtitle: String?,
                          leftIndicator: UIFareCellIndicator?,
                          button: UIFareCellButtonType,
                          size: UIFareCellSize,
                          swapTitleWithSubtitle: Bool,
                          showSeparator: Bool = true)
    
    case movement(leftTitle: String?,
                  leftSubtitle: String,
                  icon: UIImage,
                  rightTitle: String?,
                  rigthSubtitle: String?,
                  status: UIFareMovementCellStatus = .none,
                  rightButton: UIFareCellButtonType? = nil,
                  showSeparator: Bool = true)
    
    case avatar(leftTitle: String?,
                leftSubtitle: String,
                leftSeccondarySubtitle: String?,
                icon: UIImage,
                rightTitle: String?,
                rightSubtitle: String?,
                rightTag: (text: String, status: UIFareTagStatus)?,
                button: UIFareCellButtonType?,
                showSeparator: Bool = true)
    
    case checkbox(leftTitle: String?,
                  leftSubtitle: String?,
                  rightTitle: String?,
                  rightSubtitle: String?,
                  size: ComponentSize,
                  showSeparator: Bool = false)
    
    case radioButton(leftTitle: String?,
                     leftSubtitle: String?,
                     rightTitle: String? = nil,
                     rightSubtitle: String? = nil,
                     size: ComponentSize,
                     showSeparator: Bool = false)
    
    case switchButton(title: String?,
                      subtitle: String?,
                      icon: UIImage)
    
    case tag(title: String?,
             subtitle: String?,
             icon: UIImage,
             tag: (text: String, status: UIFareTagStatus),
             showSeparator: Bool)
    
    case chevron(title: String?,
                 subtitle: String?,
                 swapTitleWithSubtitle: Bool,
                 leftIndicator: UIFareCellIndicator?)
}
