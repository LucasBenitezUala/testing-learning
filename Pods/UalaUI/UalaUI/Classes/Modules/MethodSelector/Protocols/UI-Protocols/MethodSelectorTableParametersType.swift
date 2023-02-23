//
//  MethodSelectorTableParametersType.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 20/05/22.
//

import Foundation

internal protocol MethodSelectorTableParametersType {
    var tableViewCell: MethodSelectorCellModelType { get }
    var delegate: MethodSelectorTableViewDelegateType { get }
    var dataSource: MethodSelectorTableViewDataSourceType { get }
}
