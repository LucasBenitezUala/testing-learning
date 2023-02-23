//
//  UalaCarouselViewFlowLayout.swift
//  UalaUI
//
//  Created by Diego Palomares on 26/04/22.
//
// source: https://stackoverflow.com/a/49617263
import Foundation

final class UalaCarouselViewFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }
        let pageWidth = itemSize.width + minimumInteritemSpacing
        let approximatePage = collectionView.contentOffset.x/pageWidth
        let currentPage = velocity.x == 0 ? round(approximatePage) : (velocity.x < 0.0 ? floor(approximatePage) : ceil(approximatePage))
        let flickVelocity = velocity.x * 0.3
        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)
        let newHorizontalOffset = ((currentPage + flickedPages) * pageWidth) - collectionView.contentInset.left

        return CGPoint(x: newHorizontalOffset, y: proposedContentOffset.y)
    }
}
