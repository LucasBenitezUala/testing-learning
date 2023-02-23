//
//  UalaCarouselProtocols.swift
//  UalaUI
//
//  Created by Matias Palmieri on 21/04/2022.
//

import Foundation

// MARK: Protocols
public protocol UalaCarouselCellType: UICollectionViewCell {
    associatedtype ViewModel
    func configure(with viewModel: ViewModel)
    static var reuseId: String { get }
}

public protocol UalaCarouselViewDataSource: AnyObject {
    func numberOfCells() -> Int
    func cell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func getItem(at index: Int) -> UalaCarouselCellModelType
}

public protocol UalaCarouselViewDelegate: AnyObject {
    func didSelectItem(item: UalaCarouselCellModelType)
}

// MARK: ViewModel
public protocol UalaCarouselCellModelType {
    var image: UIImage { get }
    var title: String { get }
    var type: UalaCarouselItemType { get }
    var url: String? { get }
}

public protocol UalaCarouselItemType {}
