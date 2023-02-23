//
//  LoadingOption.swift
//  UalaUI
//
//  Created by uala on 16/08/22.
//

import Foundation

public protocol LoadingOption {
    var iconImage: UIImage? { get }
    var backgroundImage: UIImage? { get }
}

public struct UalintecLoadingOption: LoadingOption {
    public init() {}
    public var iconImage: UIImage? {
        return BundleImage(bundle: .Common, named: "ualintecIcon")
    }
    
    public var backgroundImage: UIImage? {
        return BundleImage(bundle: .Common, named: "backgroundUalintec")
    }
}
