//
//  UalaAsset.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 21/07/2022.
//

import UIKit

extension UIImage {
    public convenience init?(withName name: String) {
        guard let bundleURL = Bundle(for: BundleControlDummy.self).resourceURL?.appendingPathComponent("UalaFareUIImages.bundle"),
              let resourceBundle = Bundle(url: bundleURL) else {
            return nil
        }
        
        self.init(named: name, in: resourceBundle, with: nil)
    }
    
    public convenience init?(withAsset asset: Icon) {
        
        self.init(withName: asset.id)
    }
}

extension UIImageView {
    public func applyTintColor(_ color: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}

class BundleControlDummy {}
