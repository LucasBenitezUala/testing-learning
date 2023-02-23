//
//  RegistrableCell.swift
//  UalaFareUI
//
//  Created by Luis Perez on 10/08/22.
//

import UIKit

public protocol RegistrableCell: AnyObject {
    static func register(into tableView: UITableView)
    static func register(into collectionView: UICollectionView)
    static var reuseIdentifier: String { get }
}
