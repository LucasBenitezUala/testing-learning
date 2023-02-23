//
//  UIFareCardTypographyProvider.swift
//  UalaFareUI
//
//  Created by Luis Perez on 06/09/22.
//

public protocol UIFareCardTypographyFactory {
    func style(for cardType: UIFareCardType, component: UIFareCardComponent) -> TypographyStyle
}
