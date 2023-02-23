//
//  AutomaticSizedCell.swift
//  UalaFareUI
//
//  Created by Luis Perez on 10/08/22.
//

public protocol AutomaticSizedCell: AnyObject {
    static var estimatedRowHeight: CGFloat { get }
    static var dynamicCellHeight: CGFloat { get }
}
