//
//  TransactionTableViewCell.swift
//  Uala
//
//  Created by Germain Seijas on 25/7/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import UIKit
import UalaCore

open class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak public var titleCell: UILabel!
    @IBOutlet weak public var subtitleLabel: UILabel!
    @IBOutlet weak public var amountCell: UILabel!
    @IBOutlet weak public var dateLabel: UILabel!
    @IBOutlet weak public var imgInstallmentAllowed: UIImageView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customizeUI()
    }
    
    public var decorator: TransactionCellDecoratorProtocol! {
        didSet {
            guard decorator != nil else { return }
            
            fillInfo(with: decorator)
        }
    }
    
    public func configureBackgroundColor(color: UIColor) {
        self.bgView.backgroundColor = color
        self.backgroundColor = color
    }
    
    public func customizeUI() {
        self.selectionStyle = .none
        if let imgInstallmentAllowed = imgInstallmentAllowed {
            imgInstallmentAllowed.image = UIImage(named: "installment_allowed")
        }
        titleCell.font = UalaStyle.font.semiBold(withSize: 14)
        titleCell.textColor = UalaStyle.colors.fareTextMainColor
        amountCell.font = UalaStyle.font.semiBold(withSize: 14)
        amountCell.textColor = UalaStyle.colors.fareTextMainColor
        subtitleLabel.customize(style: .regularFareSecondaryLeft(size: 13))
        dateLabel.customize(style: .regularFareSecondaryRight(size: 13))
    }
    
    open func fillInfo(with decorator: TransactionCellDecoratorProtocol) {
        titleCell.text = decorator.getTitle()
        subtitleLabel.attributedText = decorator.getDescription()
        dateLabel.text = decorator.getDate()
        amountCell.attributedText = decorator.getAmount()
        imgCell.image = decorator.getIcon()
        imgInstallmentAllowed.isHidden = !decorator.showInstallmentAllowedImage()
    }
    
    public func configure(with model: TransactionCellCardInfoProtocol) {
        if let icon = model.icon {
            imgCell.image = UIImage(named: icon)
        } else if let urlImage = model.urlImage {
            imgCell.downloadImage(urlString: urlImage, contentMode: .scaleAspectFill)
            imgCell.roundCorners(.allCorners, radius: 4)
        }
        imgInstallmentAllowed.isHidden = true
        titleCell.text = translate(model.title)
        subtitleLabel.text = translate(model.subtitle)
        amountCell.isHidden = true
        dateLabel.isHidden = true
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        amountCell.isHidden = false
        dateLabel.isHidden = false
        subtitleLabel.textColor = UalaStyle.colors.fareTextSecondaryColor
    }
}
