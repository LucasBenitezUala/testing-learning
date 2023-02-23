//
//  ToastBuilder.swift
//  Alamofire
//
//  Created by Matias LaDelfa on 19/08/2021.
//

import UIKit
import Foundation

public class ToastBuilder {
    public static func loyalty(message: String, view: UIView?) -> Toast {
        Toast(message: message,
                     messageFont: .regular(size: 13),
                     container: view,
                     textColor: UIColor.black,
                     textAlignment: .left,
                     backgroundColor: UalaStyle.colors.lightYellow,
                     toastDisplayTime: 3,
                     style: DefaultToastStyle.loyalty)
    }
    
    public static func generic(message: String) -> Toast {
        Toast(message: message,
              messageFont: LabelStyle.whiteSubTitle.font,
                     textColor: UalaStyle.colors.white)
    }
    
    static func getIconConstraint(style: ToastStyle) -> CGFloat {
        style.iconConstraint
    }
    
    static func getIcon(style: ToastStyle) -> UIImage? {
        BundleImage(bundle: .Common, named: style.imageName)
    }
    
    static func getBottomInset(style: ToastStyle) -> CGFloat {
        style.bottomInset
    }
}
