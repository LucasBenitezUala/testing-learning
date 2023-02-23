//
//  UalaCarouselCell.swift
//  UalaUI
//
//  Created by Matias Palmieri on 21/04/2022.
//

import Foundation
import UIKit

// MARK: - Example Carousel Cell
public class UalaCarouselCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.customize(style: .regular(size: UalaFontBase.captionOne.rawValue, color: UalaStyle.colors.grey90))
        return title
    }()
    
    var containerView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        contentView.applyFigmaShadow(color: UalaStyle.colors.grey40,
                                     alpha: 0.1,
                                     xOffset: 0,
                                     yOffset: 2,
                                     blur: 24,
                                     spread: 0)
        containerView.backgroundColor = .white
        containerView.cornerRadius(radius: 8.0)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 12),
            title.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: 12),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0)
        ])
    }
}

extension UalaCarouselCell: UalaCarouselCellType {
    
    public typealias ViewModel = UalaCarouselCellModelType

    public func configure(with viewModel: UalaCarouselCellModelType) {
        // Config cell.
        imageView.image = viewModel.image
        title.text = viewModel.title
    }

    public static var reuseId: String {
        return "UalaCarouselCell"
    }
}
