//
//  AnswerTableViewCell.swift
//  UalaExchange
//
//  Created by Miguel Jasso on 07/10/21.
//

import UIKit
import UalaUI

protocol answerSelectionProtocol: AnyObject {
    func selected(answer: AnswerChoice?)
}

class AnswerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate: answerSelectionProtocol?
    var answer: AnswerChoice?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectAnswer(_:)))
        self.addGestureRecognizer(gesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(choice: AnswerChoice) {
        answer = choice
        descriptionLabel.text = choice.text
        descriptionLabel.font = UalaStyle.font.captionOneRegular
        radioButton.setImage(BundleImage(bundle: .Common, named: "radiobutton_inactive"), for: .normal)
        
        radioButton.setImage(BundleImage(bundle: .Common, named: "radiobutton_active"), for: .selected)
        radioButton.adjustsImageWhenHighlighted = false
        radioButton.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = ""
        radioButton.isSelected = false
    }
    
    @IBAction func selectAnswer(_ sender: UIButton) {
        delegate?.selected(answer: answer)
    }
}
