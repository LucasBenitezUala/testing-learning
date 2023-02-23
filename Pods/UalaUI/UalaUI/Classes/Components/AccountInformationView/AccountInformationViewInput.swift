//
//  AccountInformationViewInput.swift
//  UalaUI_Example
//
//  Created by Uala on 11/05/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import UalaUI

/// This is the struct that contains the configuration data for EmptyListView.
public struct AccountInformationViewInput {
    let backgroundColor: UIColor
    let textTitle: String
    let titleStyle: LabelStyle
    let textCurrency: String
    let textBalance: Double
    let balanceStyle: LabelStyle
    
    /**
     Initializes a new EmptyListViewInput with the provided params and specifications.

     - Parameters:
        - backgroundColor: The backgroundColor of the container, default value .clear
        - textTitle: The title text of the AccountInfoView, default value ""
        - titleStyle: The title text style of the AccountInfoView, default value .regularFarePrimaryLeft(size: 14),
        - textCurrency: The title text of the AccountInfoView, default value ""
        - textBalance: The title text of the AccountInfoView, default value 0
        - balanceStyle: The title text style of the AccountInfoView, default value .semiBoldFarePrimaryRight(size: 18),
     */
    public init(backgroundColor: UIColor = .white,
                textTitle: String = "",
                titleStyle: LabelStyle = .regularFarePrimaryLeft(size: 14),
                textCurrency: String = "",
                textBalance: Double = 0,
                balanceStyle: LabelStyle = .semiBoldFarePrimaryRight(size: 18)) {
        self.backgroundColor = backgroundColor
        self.textTitle = textTitle
        self.titleStyle = titleStyle
        self.textCurrency = textCurrency
        self.textBalance = textBalance
        self.balanceStyle = balanceStyle
    }
}
