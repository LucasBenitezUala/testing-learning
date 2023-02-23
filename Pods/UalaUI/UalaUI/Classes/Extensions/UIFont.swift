//
//  UIFont.swift
//  Uala
//
//  Created by Developer on 7/14/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public extension UIFont {
    
    class func regular(size: CGFloat) -> UIFont {
        return UalaStyle.font.regular(withSize: size)
    }
    
    class func bold(size: CGFloat) -> UIFont {
        return UalaStyle.font.bold(withSize: size)
    }
    
    class func semiBold(size: CGFloat) -> UIFont {
        return UalaStyle.font.semiBold(withSize: size)
    }
    
    class func light(size: CGFloat) -> UIFont {
        return UalaStyle.font.light(withSize: size)
    }

    class func extraLight(size: CGFloat) -> UIFont {
        return UalaStyle.font.extraLight(withSize: size)
    }
}
