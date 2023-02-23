//
//  DynamicCellAction.swift
//  UalaFareUI
//
//  Created by Luis Perez on 16/08/22.
//

public enum UIFareCellAction {
    case actionButtonPressed(indexPath: IndexPath)
    case switchStatusChanged(indexPath: IndexPath, isActive: Bool)
    case checkboxStatusChanged(indexPath: IndexPath, isActive: Bool)
    case radioButtonSelected(indexPath: IndexPath)
}
