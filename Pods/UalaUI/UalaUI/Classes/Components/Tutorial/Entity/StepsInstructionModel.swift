//
//  StepsInstructionModel.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 11/04/22.
//

import Foundation

public struct StepsInstructionModel: InstructionDataType {
    public let description: String?
    public let attributedElements: [UalaAttributedString]?
    public let style: LabelStyle?
    public let icon: UIImage?
    public let stepCount: String

    public init(description: String, attributedElements: [UalaAttributedString]? = nil, style: LabelStyle? = nil, stepCount: String) {
        self.description = description
        self.attributedElements = attributedElements
        self.style = style
        self.stepCount = stepCount
        self.icon = nil
    }
}
