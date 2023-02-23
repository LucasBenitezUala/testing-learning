//
//  TwoSectionOnboardingInfoCell.swift
//  UalaUI
//
//  Created by Laura Krayacich on 07/04/2021.
//

import UIKit

public class TwoSectionOnboardingInfoCell: UITableViewCell {

    @IBOutlet weak var cellIcon: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!

    // MARK: Properties
    public var twoSectionOnboardingPresenter: TwoSectionOnboardingPresenter?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }
    
    private func customizeUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.cellLabel.customize(style: .regularFarePrimaryLeft(size: 14))
    }
    
    public func configure(with item: TwoSectionOnboardingField) {
        cellLabel.text = item.text
        cellLabel.numberOfLines = 0
        cellIcon.image = CommonImage(named: item.imageName)
        if item.buttonText.isEmpty {
            linkButton.isHidden = true
        }
        linkButton.setTitle(item.buttonText, for: .normal)
        
        let attributedText: [UalaAttributedString] = item.highlightedText.map {
            
            let attributedText: UalaAttributedString = UalaLabelAttributedString(
                word: $0,
                style: .semiBoldFarePrimaryLeft(size: 16),
                delegate: nil
            )
            
            return attributedText
        }
        
        cellLabel.customize(style: .regularFarePrimaryLeft(size: 16), with: attributedText)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        twoSectionOnboardingPresenter?.router?.navigateToFee?()
    }
}
