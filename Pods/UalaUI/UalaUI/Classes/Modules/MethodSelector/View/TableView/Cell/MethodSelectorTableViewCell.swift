//
//  MethodSelectorTableViewCell.swift
//  UalaUI
//
//  Created by Agustin Jaimes on 20/05/22.
//

import Foundation
import UIKit

final class MethodSelectorTableViewCell: UITableViewCell {

    let labelStyle: LabelStyle = .regularBrownishGreyLeft(size: 17)
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        iconView.image = nil
    }
    
    private func customizeUI() {
        selectionStyle = .none
        title.text = ""
        title.customize(style: labelStyle)
    }

    func configure(with model: MethodSelectorCellModelType) {
        title.text = model.description
        iconView.image = model.image
    }
}
