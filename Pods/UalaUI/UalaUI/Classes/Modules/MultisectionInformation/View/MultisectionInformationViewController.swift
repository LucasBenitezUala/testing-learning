//
//  MultisectionInformationViewController.swift
//  Alamofire
//
//  Created by Aldana Rastrelli on 02/05/2022.
//

import UIKit

public class MultisectionInformationViewController: BaseViewController, MultisectionInformationViewProtocol {
        
    // MARK: Outlets
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var feeInfoLabel: UILabel!
        
    // MARK: Properties
    public var multisectionPresenter: MultisectionInformationPresenter?
    public var hideSecondButton = true
    public var channel: String = ""
    internal var rows: [MultisectionInformationViewRow] = []
    
    public init(presenter: MultisectionInformationPresenter) {
        self.multisectionPresenter = presenter
        super.init(nibName: String(describing: MultisectionInformationViewController.self), bundle: Bundle(for: MultisectionInformationViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecicle
    open override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
    }
    
    // MARK: private functions
    private func customizeUI() {
        navigationController?.navigationBar.tintColor = UalaStyle.colors.blue80
        backgroundView.backgroundColor = UalaStyle.colors.grey05
        
        if let title = multisectionPresenter?.viewModel?.title {
            titleLabel?.text = title
            titleLabel.customize(style: .blackTitle)
        }
        
        if let mainButtonVM = multisectionPresenter?.viewModel?.mainButton {
            configure(button: mainButton, withTitle: mainButtonVM.buttonTitle, andStyle: mainButtonVM.style)
        }
        
        if let secondaryButtonVM = multisectionPresenter?.viewModel?.secondaryButton {
            configure(button: secondButton, withTitle: secondaryButtonVM.buttonTitle, andStyle: secondaryButtonVM.style)
            hideSecondButton = false
        }
        
        secondButton.isHidden = hideSecondButton
        
        if let feeInfoText = multisectionPresenter?.viewModel?.feeInformation {
            feeInfoLabel.customize(style: .regularFareSecondaryCenter(size: 14))
            feeInfoLabel.isHidden = feeInfoText.isEmpty
            feeInfoLabel.text = feeInfoText
        }
        
        customizeTable()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customizeNavigationBar()
    }

    private func customizeNavigationBar() {
        navigationController?.setupTitle(color: .black)
    }
    
    private func customizeTable() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.sectionHeaderHeight = 50
        tableView?.separatorStyle = .none
    }
    
    public override func customizeNavigation() {
        super.customizeNavigation()
        navigationController?.navigationBar.tintColor = UalaStyle.colors.blue50
    }

    @IBAction func mainButtonTapped(_ sender: Any) {
        multisectionPresenter?.didClickMainButton(channel: channel)
    }
    
    @IBAction func secondButtonTapped(_ sender: Any) {
        multisectionPresenter?.didClickSecondButton()
    }
    
    internal func configure(button: UIButton, withTitle buttonTitle: String, andStyle style: ButtonStyle?) {
        button.setTitle(buttonTitle, for: .normal)
        if let buttonStyle = style {
            button.customize(style: buttonStyle)
        }
    }
}

// MARK: TableView
extension MultisectionInformationViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return multisectionPresenter?.getNumberOfSections() ?? 1
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.1 : 60
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        let currentSection = multisectionPresenter?.viewModel?.sections[section]
                
        let titleLabel = UILabel()
        titleLabel.text = currentSection?.sectionTitle
        titleLabel.customize(style: .semiBoldSubtitleLeft)
        titleLabel.numberOfLines = 0

        view.addSubview(titleLabel)

        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
                
        guard let action = currentSection?.buttonClosure else { return view }
        let button = UIButton()
        button.addAction(action)
        
        guard let img = currentSection?.optionalButtonIcon else {
            return view
        }
        
        button.setImage(img, for: .normal)
        view.addSubview(button)
        
        button.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        button.autoPinEdge(toSuperviewEdge: .right, withInset: 24)

        return view
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return multisectionPresenter?.numberOfRowsIn(section: section) ?? 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowsInSection = multisectionPresenter?.itemsInSection(indexPath.section)
        let rowAtIndex = rowsInSection?[indexPath.row]
        return rowAtIndex?.height ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemsInSection = multisectionPresenter?.itemsInSection(indexPath.section), !(itemsInSection.isEmpty) else {
            return UITableViewCell()
        }
        return returnCell(tableView: tableView, indexPath: indexPath, sectionItems: itemsInSection)
    }
    
    private func returnCell(tableView: UITableView, indexPath: IndexPath, sectionItems: [MultisectionInformationViewRow]) -> UITableViewCell {
        let item = sectionItems[indexPath.row]
        let cellClass = item.cellClass
        
        return cellClass.getMultisectionTableViewCell(tableView: tableView, indexPath: indexPath, item: item)
    }
}
