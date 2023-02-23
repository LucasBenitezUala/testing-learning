//
//  InstructionAttributedTableViewCell.swift
//  UalaUI
//
//  Created by Enzo Digiano on 03/05/2022.
//

import UIKit

class InstructionAttributedTableViewCell: InstructionBaseTableViewCell {

    // MARK: - Methods

    override func customizeUI() {
        descriptionLabel.customize(style: .semiBoldFarePrimaryLeft(size: 16))
    }

    override func configure(data: InstructionDataType) {
        descriptionLabel.attributedText = data.description?.html2AttStr
        icon.image = data.icon
    }
}
