//
//  Loader.swift
//  SOLID
//
//  Created by Francisco J. Saldivar on 23/11/22.
//

import UIKit

private final class Loader: UIView {
    
    private let indicator: UIActivityIndicatorView = .init(style: UIActivityIndicatorView.Style.gray)
    private let zero: CGFloat = 0
    private let loaderWidth: CGFloat = 40
    private let loaderHeight: CGFloat = 40

    required init(coder: NSCoder) {
        fatalError("Not implement")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    func setUp() {
        indicator.frame = CGRect(x: zero, y: zero, width: loaderWidth, height: loaderHeight)
        indicator.center = center
        backgroundColor = UIColor(white: 1, alpha: 0.5)
        addSubview(indicator)
        bringSubviewToFront(indicator)
        indicator.accessibilityIdentifier = "SOLID"
    }
    
    func start() {
        indicator.startAnimating()
    }
}

extension UIViewController {
    
    private var indicator: Loader {
        
        let frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let loaderView: Loader = Loader(frame: frame)
        loaderView.center = view.center
        view.addSubview(loaderView)
        view.bringSubviewToFront(loaderView)
        return loaderView
    }
    
    func showLoading() {
        indicator.start()
    }
    
    func hideLoading() {
        view.subviews.forEach {
            if type(of: $0.self) == Loader.self {
                $0.removeFromSuperview()
            }
        }
    }
}
