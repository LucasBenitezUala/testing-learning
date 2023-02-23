//
//  UalaSearchTableViewCell.swift
//  UalaUI
//
//  Created by Ariel Congestri on 07/04/2020.
//

import UIKit

class UalaSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var firstDividerView: UIView!
    @IBOutlet weak var secondDividerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ovalImageView: UIImageView!
    @IBOutlet weak var emptySpaceLabel: UILabel!
        
    func configureName(_ name: String) {
        self.nameLabel.text = name
    }

    func canSelectModeCell(selected: Bool) {
        ovalImageView.image = BundleImage(bundle: .Common, named: "oval_grey")
        ovalImageView.isHidden = false
        secondDividerView.isHidden = true
        firstDividerView.isHidden = true
        emptySpaceLabel.isHidden = true
        if selected {
            ovalImageView.image = BundleImage(bundle: .Common, named: "oval_selected")
        }
    }
}
