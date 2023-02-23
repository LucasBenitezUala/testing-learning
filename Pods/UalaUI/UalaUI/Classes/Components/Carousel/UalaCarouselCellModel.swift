//
//  UalaCarouselCellModel.swift
//  UalaUI
//
//  Created by Matias Palmieri on 21/04/2022.
//

import Foundation
import UIKit

// MARK: Model
public struct UalaCarouselCellModel: UalaCarouselCellModelType {
    
    public var type: UalaCarouselItemType
    public var image: UIImage
    public var title: String
    public var url: String?

    public init (image: UIImage, title: String, type: UalaCarouselItemType, url: String? = nil) {
        self.image = image
        self.title = title
        self.type = type
        self.url = url
    }
}
