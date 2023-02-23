//
//  UITableViewCell+EXT.swift
//  UalaFareUI
//
//  Created by Luis Perez on 10/08/22.
//

public extension RegistrableCell where Self: UITableViewCell {
    static func register(into tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: Self.reuseIdentifier)
    }
    
    static func register(into collectionView: UICollectionView) {}
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
