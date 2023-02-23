//
//  InformationListTableViewCell.swift
//  UalaUI
//
//  Created by Mario García on 21/10/21.
//

import UIKit

class InformationListTableViewCell: UITableViewCell {

    @IBOutlet weak var separatorView: UIView! {
        didSet {
            separatorView.backgroundColor = UalaStyle.colors.grey40
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = UalaStyle.colors.grey90
            titleLabel.font = .regular(size: 16.0)
        }
    }
    @IBOutlet weak var subTitleLabel: UILabel! {
        didSet {
            subTitleLabel.textColor = UalaStyle.colors.grey90
            subTitleLabel.font = .regular(size: 14.0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UalaStyle.colors.grey05
        selectionStyle = .none
    }
    
    func setup(item: InformationListItem) {
        titleLabel.attributedText = item.title
        subTitleLabel.attributedText = item.subtitle
    }
}
