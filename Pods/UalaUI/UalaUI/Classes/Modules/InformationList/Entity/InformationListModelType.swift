//
//  InformationListModelType.swift
//  Alamofire
//
//  Created by Mario García on 21/10/21.
//

import Foundation

public protocol InformationListModelType: AnyObject {
    var title: NSAttributedString { get }
    var items: [InformationListItem] { get }
    var buttonStyle: ButtonStyle { get }
    var buttonAction: InformationViewAction? { get }
}

public struct InformationListItem {
    let title: NSAttributedString
    let subtitle: NSAttributedString
    
    public init(title: NSAttributedString, subtitle: NSAttributedString) {
        self.title = title
        self.subtitle = subtitle
    }
}
