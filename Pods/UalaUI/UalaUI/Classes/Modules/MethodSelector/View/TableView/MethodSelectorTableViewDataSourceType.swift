//
//  MethodSelectorTableViewDataSourceType.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 20/05/22.
//

import Foundation
import UIKit

internal protocol MethodSelectorTableViewDataSourceType: UITableViewDataSource {
    var items: [MethodSelectorCellModelType] { get }
}

final class MethodSelectorTableViewDataSourceAdapter: NSObject, MethodSelectorTableViewDataSourceType {

    internal let items: [MethodSelectorCellModelType]

    init(with items: [MethodSelectorCellModelType]) {
        self.items = items
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = items[indexPath.row] as? MethodSelectorCellModelType,
              let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MethodSelectorTableViewCell.self),
                                                       for: indexPath) as? MethodSelectorTableViewCell else {
            fatalError("Not available")
        }
        cell.configure(with: item)
        return cell
    }
}
