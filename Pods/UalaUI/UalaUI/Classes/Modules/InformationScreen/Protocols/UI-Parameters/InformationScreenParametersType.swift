//
//  InformationScreenParametersType.swift
//  Alamofire
//
//  Created by Rodrigo Torres on 17/05/2022.
//

public protocol InformationScreenParametersType {
    var image: UIImage? { get }
    var title: NSAttributedString { get }
    var description: NSAttributedString { get }
    var primaryButtonTitle: String { get }
    var secondaryButtonTitle: String? { get }
}

public extension InformationScreenParametersType {
    var image: UIImage? { nil }
    var secondaryButtonTitle: String? { nil }
}
