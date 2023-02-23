//
//  MethodSelectorTableViewDelegateType.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 20/05/22.
//

import Foundation

internal protocol MethodSelectorTableViewDelegateType: UITableViewDelegate {
    var presenter: MethodSelectorPresenterType { get }
}

final class MethodSelectorTableViewDelegate: NSObject, MethodSelectorTableViewDelegateType {
    let presenter: MethodSelectorPresenterType

    init(with presenter: MethodSelectorPresenterType) {
        self.presenter = presenter
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let method: MethodSelectorCellModelType = presenter.items[indexPath.row]
        presenter.selected(method)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
