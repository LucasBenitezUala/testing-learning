//
//  WeakObjectContainer.swift
//  UalaFareUI
//
//  Created by Luis Perez on 20/07/22.
//

final class WeakObjectContainer<T: AnyObject> {
    weak var object: T?
                                                    
    init(object: T) {
        self.object = object
    }
}
