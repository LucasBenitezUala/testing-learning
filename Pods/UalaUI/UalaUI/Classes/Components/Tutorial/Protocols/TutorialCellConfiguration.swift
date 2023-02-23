//
//  TutorialCellConfiguration.swift
//  UalaUI
//
//  Created by Alan Valencia on 17/03/22.
//

import Foundation

public protocol TutorialCellConfiguration {
    var backgroundColor: UIColor {get}
    var imageWidthHeight: CGFloat {get}
    /**
     The spacing between arrangedSubviews (ImageView-Label)
     */
    var itemsSpacing: CGFloat {get}
    /**
     The aligment of the arrangedSubviews when Label is higher than ImageView;
      e.g., top/center edges in a horizontal stack
     */
    var itemsAligment: UIStackView.Alignment {get}
}

public extension TutorialCellConfiguration {
    
    var imageWidthHeight: CGFloat {
        return 40
    }
    
    var itemsSpacing: CGFloat {
        return 16
    }
    
    var itemsAligment: UIStackView.Alignment {
        return .top
    }
}
