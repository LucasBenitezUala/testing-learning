//
//  AlertFieldStyle.swift
//  Alamofire
//
//  Created by Matias Palmieri on 21/02/2022.
//

import Foundation

public enum AlertFieldStyle {
    case errorRed
    case errorBlue
    
    var textColor: UIColor {
        switch self {
        case .errorRed:
            return UalaStyle.colors.red70
        case .errorBlue:
            return UalaStyle.colors.blue50
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .errorRed:
            return UalaStyle.colors.red10
        case .errorBlue:
            return UalaStyle.colors.blue10
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .errorRed:
            return 20.0
        case .errorBlue:
            return 8.0
        }
    }
    
    var image: UIImage? {
        switch self {
        case .errorRed:
            return BundleImage(bundle: .Loans, named: "ic-warning-red")
        case .errorBlue:
            return BundleImage(bundle: .Common, named: "info_circle_filled")
        }
    }
    
    var font: UIFont? {
            return UalaStyle.font.captionTwoRegular
    }
}
