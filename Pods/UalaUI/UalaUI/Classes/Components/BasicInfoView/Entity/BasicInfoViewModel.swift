//
//  BasicInfoViewModel.swift
//
//  Created by Monserrath Castro on 21/04/22.
//  Copyright © 2022 Ualá. All rights reserved.
//

import UalaCore
import UIKit

public protocol BasicInfoViewModelType {
    var navigationTitle: String? { get }
    var title: String? { get }
    var description: String? { get }
    var backgroundColor: UIColor? { get }
    var backgroundImage: String? { get }
    var backgroundImageBundle: StringTables? { get }
}

public struct BasicInfoViewModel: BasicInfoViewModelType {
    public var navigationTitle: String?
    public var title: String?
    public var description: String?
    public var backgroundColor: UIColor?
    public var backgroundImage: String?
    public var backgroundImageBundle: StringTables?

    public init(
        navigationTitle: String? = nil,
        title: String? = nil,
        description: String? = nil,
        backgroundColor: UIColor? = nil,
        backgroundImage: String? = nil,
        backgroundImageBundle: StringTables? = nil
    ) {
        self.navigationTitle = navigationTitle
        self.title = title
        self.description = description
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.backgroundImageBundle = backgroundImageBundle
    }
}
