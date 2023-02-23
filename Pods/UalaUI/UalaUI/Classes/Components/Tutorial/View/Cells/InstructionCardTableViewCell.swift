//
//  InstructionCardTableViewCell.swift
//  UalaUI
//
//  Created by Alan Valencia on 16/03/22.
//

import UIKit

class InstructionCardTableViewCell: InstructionBaseTableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!

    // MARK: - Methods
    
    override func customizeUI() {
        descriptionLabel.customize(style: .regularFarePrimaryLeft(size: 16))
        containerView.cornerRadius(radius: 8)
    }

    override func configure(data: InstructionDataType) {
        descriptionLabel.text = data.description
        icon.image = data.icon
    }
    
    override func update(configuration: TutorialCellConfiguration?) {
        guard let configuration = configuration else {
            return
        }
        containerView.backgroundColor = configuration.backgroundColor
        stackView.spacing = configuration.itemsSpacing
        stackView.alignment = configuration.itemsAligment
        imageViewWidthConstraint.constant = configuration.imageWidthHeight
    }
}
