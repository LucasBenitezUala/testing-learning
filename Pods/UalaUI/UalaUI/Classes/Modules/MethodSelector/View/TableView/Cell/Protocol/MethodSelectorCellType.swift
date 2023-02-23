//
//  MethodSelectorCellType.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 20/05/22.
//

import Foundation

public protocol MethodSelectorCellModelType {
    var image: UIImage? { get }
    var description: String { get }
    var method: String { get }
}

public extension MethodSelectorCellModelType {
    var image: UIImage? { nil }
}
