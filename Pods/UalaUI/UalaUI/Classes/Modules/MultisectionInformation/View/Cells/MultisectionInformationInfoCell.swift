//
//  MultisectionInformationInfoCell.swift
//  UalaUI
//
//  Created by Aldana Rastrelli on 02/05/2022.
//

import UIKit

public class MultisectionInformationInfoCell: UITableViewCell, MultisectionInformationCellProtocol {

    @IBOutlet weak var cellIcon: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!

    // MARK: Properties
    public var multisectionPresenter: MultisectionInformationPresenter?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }
    
    private func customizeUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.cellLabel.customize(style: .regularFarePrimaryLeft(size: 14))
        self.cellLabel.numberOfLines = 0
    }
    
    func configure(with item: MultisectionInformationViewRow) {
        cellLabel.text = item.rowTitle
        cellIcon.image = CommonImage(named: item.icon)
        if item.buttonText.isEmpty {
            linkButton.isHidden = true
        }
        linkButton.setTitle(item.buttonText, for: .normal)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        multisectionPresenter?.router?.navigateToFee()
    }
    
    public func getMultisectionTableViewCell(tableView: UITableView, indexPath: IndexPath, item: MultisectionInformationViewRow) -> UITableViewCell {
        tableView.register(MultisectionInformationInfoCell.self)
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MultisectionInformationInfoCell
        cell.configure(with: item)
        cell.multisectionPresenter = MultisectionInformationPresenter()
        return cell
    }
}
