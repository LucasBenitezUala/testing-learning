//
//  ImageManager.swift
//  Alamofire
//
//  Created by Aldo Martinez on 26/04/22.
//

import Foundation
import UIKit.UIImage
import Combine

public final class ImageManager {
    
    public static let shared = ImageManager()
    
    private let cache: ImageCache
    
    private lazy var queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 10
        return queue
    }()

    public init(cache: ImageCache = ImageCacheImpl()) {
        self.cache = cache
    }

    public func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache.image(for: url) {
            return Just(image).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, _) -> UIImage? in return UIImage(data: data) }
            .catch { _ in return Just(nil) }
            .handleEvents(receiveOutput: { [weak self] image in
                guard let self = self, let image = image else { return }
                self.cache.add(image, for: url)
            })
            .subscribe(on: queue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
