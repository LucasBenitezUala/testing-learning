//
//  DefaultPlaceholderCell.swift
//  UalaFareUI
//
//  Created by Luis Perez on 10/08/22.
//

import UIKit

public final class DefaultUIFarePlaceholderCell: UIFarePlaceholderCell {
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    public override func configurePlaceholder(theme: Theme) {
        setupContainerViewIfNeeded(theme: theme)
        super.configurePlaceholder(theme: theme)
    }
    
    private func setupContainerViewIfNeeded(theme: Theme) {
        if containerStackView.arrangedSubviews.isEmpty {
            containerStackView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(containerStackView)
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                           constant: 10).isActive = true
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -10).isActive = true
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: 10).isActive = true
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -10).isActive = true
            
            let squareView = UIView()
            squareView.layer.cornerRadius = 4
            containerStackView.addArrangedSubview(squareView)
            squareView.widthAnchor.constraint(equalToConstant: 40).isActive = true
            squareView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            let rectangleView = UIView()
            rectangleView.layer.cornerRadius = 4
            containerStackView.addArrangedSubview(rectangleView)
        }
    }
}

extension DefaultUIFarePlaceholderCell: RegistrableCell, AutomaticSizedCell {
    public static var estimatedRowHeight: CGFloat {
        return 60
    }
    
    public static var dynamicCellHeight: CGFloat {
        return UITableView.automaticDimension
    }
}
