//
//  UIFareCardModelProvider.swift
//  UalaFareUI
//
//  Created by Luis Perez on 06/09/22.
//

public protocol UIFareCardModelFactory {
    func themedModel(for type: UIFareCardType, theme: Theme) -> UIFareCardModel
}
