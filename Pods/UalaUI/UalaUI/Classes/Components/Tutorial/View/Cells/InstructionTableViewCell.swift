//
//  InstructionTableViewCell.swift
//  UalaUI
//
//  Created by Monserrath Castro on 11/11/21.
//

import UIKit

class InstructionTableViewCell: InstructionBaseTableViewCell {

    // MARK: - Methods

    override func customizeUI() {
        descriptionLabel.customize(style: .regularFarePrimaryLeft(size: 16))
    }

    override func configure(data: InstructionDataType) {
        descriptionLabel.text = data.description
        icon.image = data.icon
    }
}
