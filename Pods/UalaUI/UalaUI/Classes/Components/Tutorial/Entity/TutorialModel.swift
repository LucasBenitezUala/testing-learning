//
//  TutorialModel.swift
//
//  Created by Monserrath Castro on 07/10/21.
//  Copyright © 2021 Ualá. All rights reserved.
//

import UIKit

public protocol TutorialViewModelType {
    var type: TutorialViewType { get }
    var navigationTitle: String? { get }
    var title: String? { get }
    var subtitle: String? { get }
    var primaryAction: TutorialActionModelProtocol? { get }
    var instructions: [InstructionDataType] { get }
    var backAction: TutorialActionModelProtocol? { get }
    var cellStyle: TutorialCellStyle {get}
    var buttonGradient: TutorialButtonGradientType {get}
    var backgroundColor: UIColor? {get}
    var configuration: TutorialCellConfiguration? {get}
}

public struct TutorialViewModel: TutorialViewModelType {
    public var type: TutorialViewType
    public var navigationTitle: String?
    public var title: String?
    public var subtitle: String?
    public var primaryAction: TutorialActionModelProtocol?
    public var instructions: [InstructionDataType]
    public var backAction: TutorialActionModelProtocol?
    public var cellStyle: TutorialCellStyle
    public var buttonGradient: TutorialButtonGradientType
    public var backgroundColor: UIColor?
    
    public var configuration: TutorialCellConfiguration? {
        switch cellStyle {
        case .plain:
            return nil
        case .plainHtmlAttributed:
            return nil
        case .card(let config):
            return config
        case .step:
            return nil
        }
    }

    public init(
        type: TutorialViewType,
        navigationTitle: String? = nil,
        title: String? = nil,
        subtitle: String? = nil,
        primaryAction: TutorialActionModelProtocol? = nil,
        instructions: [InstructionDataType],
        backAction: TutorialActionModelProtocol? = nil,
        cellStyle: TutorialCellStyle = .plain,
        buttonGradient: TutorialButtonGradientType = TutorialButtonGradientType.defaultValue,
        backgroundColor: UIColor? = nil
    ) {
        self.type = type
        self.navigationTitle = navigationTitle
        self.title = title
        self.subtitle = subtitle
        self.primaryAction = primaryAction
        self.backAction = backAction
        self.instructions = instructions
        self.cellStyle = cellStyle
        self.buttonGradient = buttonGradient
        self.backgroundColor = backgroundColor
    }
}

public protocol InstructionDataType {
    var description: String? { get }
    var icon: UIImage? { get }
}

public struct InstructionModel: InstructionDataType {
    public let description: String?
    public let icon: UIImage?

    public init(description: String, icon: UIImage?) {
        self.description = description
        self.icon = icon
    }
}

public protocol TutorialViewType {}

public protocol TutorialActionType {}

public protocol TutorialActionModelProtocol {
    var title: String? { get }
    var delegate: TutorialActionDelegate? { get }
    var type: TutorialActionType { get }
}

public protocol TutorialActionDelegate: AnyObject {
    func tutorialView(tutorialType: TutorialViewType, actionExecuted: TutorialActionType)
}
