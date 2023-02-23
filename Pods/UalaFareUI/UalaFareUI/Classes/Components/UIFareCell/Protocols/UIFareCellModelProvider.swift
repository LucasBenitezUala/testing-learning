//
//  DynamicInfoCellModelProvider.swift
//  UalaFareUI
//
//  Created by Luis Perez on 27/07/22.
//

protocol UIFareCellModelProvider: AnyObject {
    func model(theme: Theme, typographyProvider: ThemeTypographyProvider, type: UIFareCellType) -> UIFareCellModel
}
