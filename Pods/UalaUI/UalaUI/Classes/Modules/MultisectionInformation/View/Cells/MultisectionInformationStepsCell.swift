//
//  MultisectionInformationStepsCell.swift
//  UalaUI
//
//  Created by Aldana Rastrelli on 02/05/2022.
//

import UIKit

public class MultisectionInformationStepsCell: UITableViewCell, MultisectionInformationCellProtocol {

    @IBOutlet weak var cellIcon: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    
    // MARK: Properties
    public var multisectionPresenter: MultisectionInformationPresenter?
    
    // MARK: functions
    public override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }
    
    private func customizeUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.cellLabel.customize(style: .regularFarePrimaryLeft(size: 16))
        self.cellLabel.numberOfLines = 0
    }
    
    public func configure(with item: MultisectionInformationViewRow) {
        cellLabel.text = item.rowTitle
        cellIcon.image = CommonImage(named: item.icon)
        if item.buttonText.isEmpty {
            linkButton.isHidden = true
        }
        linkButton.setTitle(item.buttonText, for: .normal)
    }
    
    // MARK: Actions
    @IBAction func buttonTapped(_ sender: Any) {
        multisectionPresenter?.router?.pushCreatePin(isReprinted: false)
    }
    
    public func getMultisectionTableViewCell(tableView: UITableView, indexPath: IndexPath, item: MultisectionInformationViewRow) -> UITableViewCell {
            tableView.register(MultisectionInformationStepsCell.self)
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MultisectionInformationStepsCell
            cell.configure(with: item)
            cell.multisectionPresenter = MultisectionInformationPresenter()
            return cell
        }
}
