//
//  TitleHeaderView.swift
//  UalaUI
//
//  Created by uala on 23/02/22.
//

import UIKit

public class TitleHeaderView: UIView {

    private var titleLabel: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func customizeUI() {
        self.backgroundColor = .clear
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.customize(style: .mediumBlackishLeft(size: 14))
        self.addSubview(titleLabel)
        
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
    public func configure(with title: String, labelStyle: LabelStyle = .mediumBlackishLeft(size: 14)) {
        titleLabel.text = title
        titleLabel.customize(style: labelStyle)
    }
}
