//
//  UalaCarouselProvider.swift
//  UalaUI
//
//  Created by Matias Palmieri on 21/04/2022.
//

import Foundation

// MARK: Provider
public class UalaCarouselProvider: UalaCarouselViewDataSource {

    private let models: [UalaCarouselCellModelType]
    private let cellReuseIdentifier = "UalaCarouselCell"

    public init(models: [UalaCarouselCellModelType]) {
        self.models = models
    }

    public func numberOfCells() -> Int {
        models.count
    }

    public func cell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? UalaCarouselCell else {
            return UICollectionViewCell()
        }
        var item = models[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    public func getItem(at index: Int) -> UalaCarouselCellModelType {
        models[index]
    }
}
