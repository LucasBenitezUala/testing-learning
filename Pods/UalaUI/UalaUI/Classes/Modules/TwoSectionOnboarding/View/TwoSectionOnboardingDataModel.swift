//
//  TwoSectionOnboardingDataModel.swift
//  UalaUI
//
//  Created by Laura Krayacich on 07/04/2021.
//

import Foundation
import UIKit

public struct TwoSectionOnboardingDataModel {
    
    public let mainButtonTitle: String
    public let mainButtonStyle: ButtonStyle
    public let secondButtonStyle: ButtonStyle
    public let secondButtonTitle: String
    public let title: String
    public let fields: [[TwoSectionOnboardingField]]
    public let subtitle: String
    public let feeInformation: String
    
    public init(mainButtonTitle: String, secondButtonTitle: String, mainButtonStyle: ButtonStyle,
                secondButtonStyle: ButtonStyle, title: String, fields: [[TwoSectionOnboardingField]],
                subtitle: String, feeInfo: String? = nil) {
        self.title = title
        self.mainButtonTitle = mainButtonTitle
        self.mainButtonStyle = mainButtonStyle
        self.fields = fields
        self.subtitle = subtitle
        self.secondButtonStyle = secondButtonStyle
        self.secondButtonTitle = secondButtonTitle
        self.feeInformation = feeInfo ?? ""
    }
}

public struct TwoSectionOnboardingField {
    
    let imageName: String
    let text: String
    let fieldType: TwoSectionOnboardingFieldType
    let buttonText: String
    let textStyle: LabelStyle
    let highlightedText: [String]
    
    public init(
        imageName: String,
        text: String,
        fieldType: TwoSectionOnboardingFieldType,
        buttonText: String,
        textStyle: LabelStyle = .regularFarePrimaryLeft(size: 16),
        highlightedText: [String] = []
    ) {
        self.imageName = imageName
        self.text = text
        self.fieldType = fieldType
        self.buttonText = buttonText
        self.textStyle = textStyle
        self.highlightedText = highlightedText
    }
}

public enum TwoSectionOnboardingFieldType {
    case step
    case info
}
