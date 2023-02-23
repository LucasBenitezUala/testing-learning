//
//  InformationListViewController.swift
//  UalaUI
//
//  Created by Mario García on 21/10/21.
//

import UIKit

public class InformationListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(InformationListTableViewCell.self)
            tableView.backgroundColor = .clear
            tableView.dataSource = self
            tableView.delegate = self
            tableView.backgroundColor = UalaStyle.colors.grey05
            tableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.setTitle("", for: .normal)
            closeButton.setImage(BundleImage(bundle: .Common, named: "ic_close_black"), for: .normal)
            closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        }
    }
    @IBOutlet weak var bottomButton: UIButton! 
    private lazy var headerView: UalaTableViewTitleHeader = {
        let headerView = UalaTableViewTitleHeader()
        headerView.setup(withTitle: viewPresenter.viewTitle)
        return headerView
    }()
    private var viewPresenter: InformationListPresenterViewInterface

    init(presenter: InformationListPresenterViewInterface) {
        viewPresenter = presenter
        super.init(nibName: String(describing: InformationListViewController.self),
                   bundle: Bundle(for: InformationListViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarHidden = true
        viewPresenter.setOutput(view: self)
        setupUI()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.layoutTableHeaderView(headerViewHeight: headerView.intrinsicContentHeight)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame.size.width = view.frame.size.width
        headerView.setNeedsLayout()
    }
    
    private func setupUI() {
        view.backgroundColor = UalaStyle.colors.grey05
        tableView.tableHeaderView = headerView

        if viewPresenter.buttonTitle.isEmpty {
            bottomButton.isHidden = true
        } else {
            bottomButton.setTitle(viewPresenter.buttonTitle, for: .normal)
            bottomButton.customize(style: viewPresenter.buttonStyle)
            bottomButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        }
    }
    
    @objc private func actionButtonPressed() {
        viewPresenter.performButtonAction()
    }
    
    @objc private func closeButtonPressed() {
        viewPresenter.closeButtonAction()
    }
}

extension InformationListViewController: InformationListViewPresenterInterface {
    func updateData() {
        tableView.reloadData()
    }
}

extension InformationListViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UalaStyle.colors.grey05
        return footer
    }
        
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewPresenter.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as InformationListTableViewCell
        cell.setup(item: viewPresenter.items[indexPath.row])
        return cell
    }
}
