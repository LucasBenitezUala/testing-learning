//
//  InstructionBaseTableViewCell.swift
//  UalaUI
//
//  Created by Alan Valencia on 16/03/22.
//

import UIKit

protocol InstructionConfigurator {
    func customizeUI()
    func configure(data: InstructionDataType)
    func update(configuration: TutorialCellConfiguration?)
}

class InstructionBaseTableViewCell: UITableViewCell, InstructionConfigurator {
    
    // MARK: - Outlets
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }
    
    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()

        icon.image = nil
    }
    
    // MARK: - InstructionConfigurator
    
    func customizeUI() {}
    
    func configure(data: InstructionDataType) {}
    
    func update(configuration: TutorialCellConfiguration?) {}
}
