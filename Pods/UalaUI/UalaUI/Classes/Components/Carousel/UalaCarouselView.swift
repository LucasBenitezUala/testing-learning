//
//  UalaCarousel.swift
//  Alamofire
//
//  Created by Matias Palmieri on 20/04/2022.
//

import Foundation
import UIKit

// MARK: Generic View
public class UalaCarouselView<T: UalaCarouselCellType>: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    enum CarouselSizes: CGFloat {
        case inset = 24.0
        case minimumInteritem = 10
        case scale = 0.4
    }
    weak public var delegate: UalaCarouselViewDelegate?
    private let collectionView: UICollectionView = {
        let width = UIScreen.main.bounds.width - (2 * CarouselSizes.inset.rawValue)
        let layout = UalaCarouselViewFlowLayout()
        layout.minimumInteritemSpacing = CarouselSizes.minimumInteritem.rawValue
        layout.minimumLineSpacing = CarouselSizes.minimumInteritem.rawValue
        layout.sectionInset = UIEdgeInsets(top: 0, left: CarouselSizes.inset.rawValue, bottom: 0, right: CarouselSizes.inset.rawValue)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width, height: width * CarouselSizes.scale.rawValue)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.clipsToBounds = false
        collection.backgroundColor = .clear
        return collection
    }()
    private var provider: UalaCarouselViewDataSource?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        collectionView.register(T.self, forCellWithReuseIdentifier: T.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    public func configure(provider: UalaCarouselViewDataSource) {
        self.provider = provider
        collectionView.reloadData()
    }
    
    // MARK: CollectionViewDelegates
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        provider?.numberOfCells() ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        provider?.cell(collectionView: collectionView, indexPath: indexPath) ?? UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = provider?.getItem(at: indexPath.row) else { return }
        delegate?.didSelectItem(item: item)
    }
}
