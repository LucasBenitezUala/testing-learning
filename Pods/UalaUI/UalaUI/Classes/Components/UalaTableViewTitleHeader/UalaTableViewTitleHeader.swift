//
//  UalaTableViewTitleHeader.swift
//  UalaUI
//
//  Created by Mario García on 21/10/21.
//

import UIKit

class UalaTableViewTitleHeader: XibView {
    private struct Config {
        static let headerSizeMargin: CGFloat = 60.0
        static let headerWidthMargin: CGFloat = 48.0
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = UalaStyle.colors.grey90
            titleLabel.font = .regular(size: 22.0)
            titleLabel.numberOfLines = 0
        }
    }
    
    var intrinsicContentHeight: CGFloat {
        let titleHeightThatFits: CGFloat = titleLabel.sizeThatFits(CGSize(width: frame.size.width - Config.headerWidthMargin,
                                                                          height: CGFloat.infinity)).height
        let sizeMargin: CGFloat = Config.headerSizeMargin
        return titleHeightThatFits + sizeMargin
    }
    
    func setup(withTitle title: NSAttributedString) {
        view?.backgroundColor = UalaStyle.colors.grey05
        titleLabel.attributedText = title
    }
}
