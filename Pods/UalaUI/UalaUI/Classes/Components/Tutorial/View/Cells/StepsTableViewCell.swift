//
//  StepsTableViewCell.swift
//  Alamofire
//
//  Created by Agustin Jaimes on 07/04/22.
//

import UIKit
import UalaUtils

final class StepsTableViewCell: InstructionBaseTableViewCell {

    fileprivate let descriptionSize: CGFloat = 15.0
    fileprivate let stepSize: CGFloat = 11.0
    fileprivate let defaultRadius: CGFloat = 0.5
    fileprivate let borderSize: CGFloat = 0.75

    @IBOutlet weak var currentStepLabel: UILabel!

    // MARK: - Methods
    override func customizeUI() {
        descriptionLabel.customize(style: .semiBoldFareSecondaryLeft(size: descriptionSize))
        currentStepLabel.customize(style: .regularFarePrimaryCenter(size: stepSize))
        currentStepLabel.addBorder(borderSize, color: .darkGray)
        currentStepLabel.cornerRadius(radius: defaultRadius * currentStepLabel.bounds.width)
    }

    override func configure(data: InstructionDataType) {
        guard let data = data as? StepsInstructionModel else { return }
        setupText(stepModel: data)
        currentStepLabel.text = data.stepCount
    }
    
    private func setupText(stepModel: StepsInstructionModel) {
        guard let description = stepModel.attributedElements, let style = stepModel.style else {
            descriptionLabel.text = stepModel.description
            return
        }
        descriptionLabel.text = stepModel.description
        descriptionLabel.customize(style: style, with: description)
    }
}
