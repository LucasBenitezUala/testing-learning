//
//  ImageCache.swift
//  Alamofire
//
//  Created by Aldo Martinez on 26/04/22.
//

import UIKit

public protocol ImageCache: class {
    func image(for url: URL) -> UIImage?
    func add(_ image: UIImage?, for url: URL)
    func remove(for url: URL)
    func removeAll()
}

public final class ImageCacheImpl: ImageCache {

    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = 100
        return cache
    }()
    
    private let lock = NSLock()
    
    public init() {}

    public func image(for url: URL) -> UIImage? {
        lock.lock()
        defer {
            lock.unlock()
        }
        guard let image = imageCache.object(forKey: url as AnyObject) as? UIImage  else {
            return nil
        }
        return image
    }

    public func add(_ image: UIImage?, for url: URL) {
        guard let image = image else { return remove(for: url) }
        lock.lock()
        defer {
            lock.unlock()
        }
        imageCache.setObject(image, forKey: url as AnyObject, cost: 1)
    }

    public func remove(for url: URL) {
        lock.lock()
        defer {
            lock.unlock()
        }
        imageCache.removeObject(forKey: url as AnyObject)
    }

    public func removeAll() {
        lock.lock()
        defer {
            lock.unlock()
        }
        imageCache.removeAllObjects()
    }
}
