//
//  MethodSelectorViewController.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 19/05/22.
//

import Foundation

final class MethodSelectorViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    private let dependencies: MethodSelectorDependenciesType
    private let dataSource: MethodSelectorTableViewDataSourceType
    private let delegate: MethodSelectorTableViewDelegateType

    init(with dependencies: MethodSelectorDependenciesType,
         presenter: MethodSelectorPresenterType) {
        self.dependencies = dependencies
        self.dataSource = MethodSelectorTableViewDataSourceAdapter(with: presenter.items)
        self.delegate = MethodSelectorTableViewDelegate(with: presenter)
        super.init(nibName: String(describing: MethodSelectorViewController.self),
                   bundle: Bundle(for: type(of: self)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        customizeTable()
    }
    
    private func customizeUI() {
        titleLabel.customize(style: dependencies.titleStyle)
        titleLabel.text = dependencies.title
    }

    private func customizeTable() {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.register(MethodSelectorTableViewCell.self)
        tableView.tableFooterView = UIView(frame: .zero)
    }
}
