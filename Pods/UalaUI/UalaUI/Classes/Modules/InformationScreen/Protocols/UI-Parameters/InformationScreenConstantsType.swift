//
//  InformationScreenConstantsType.swift
//  Alamofire
//
//  Created by Rodrigo Torres on 17/05/2022.
//

import Foundation

public protocol InformationScreenConstantsType {
    var imageViewContentMode: UIView.ContentMode { get }
    var titleStyle: LabelStyle? { get }
    var descriptionStyle: LabelStyle? { get }
    var descriptionHasInteraction: Bool { get }
    var primaryActionStyle: ButtonStyle { get }
    var secondaryActionStyle: ButtonStyle? { get }
}

public extension InformationScreenConstantsType {
 
    var imageViewContentMode: UIView.ContentMode { .center }
    var titleStyle: LabelStyle? { nil }
    var descriptionStyle: LabelStyle? { nil }
    var descriptionHasInteraction: Bool { false }
    var primaryActionStyle: ButtonStyle { .blue }
    var secondaryActionStyle: ButtonStyle { .normal }
}
