//
//  UalaLoaderView.swift
//  Uala
//
//  Created by Nicolas on 19/9/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import UIKit
import UalaCore

public class UalaLoader: UIView {
    
    private var progressView: ProgressView!
    public static var sharedLoader: UalaLoader = ServiceLocator.inject()
    var frontWindow: UIWindow?
    
    public init(window: UIWindow) {
        super.init(frame: .zero)
        self.frontWindow = window
        customizeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func customizeUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        alpha = 0.9
        progressView = ProgressView(frame: .zero)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: centerYAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 60),
            progressView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    public func show() {
        startProgresLoader()
    }
}

extension UalaLoader: CAAnimationDelegate {
    
    func start() {
        startProgresLoader()
    }
    
    public func hide() {
        progressView.stopAnimation()
        isHidden = true
        self.removeFromSuperview()
    }

    func startProgresLoader() {
        guard let frontWindow = frontWindow else { return }
        isHidden = false
        frontWindow.endEditing(true)
        frontWindow.addSubview(self)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: frontWindow.topAnchor),
            bottomAnchor.constraint(equalTo: frontWindow.bottomAnchor),
            leadingAnchor.constraint(equalTo: frontWindow.leadingAnchor),
            trailingAnchor.constraint(equalTo: frontWindow.trailingAnchor)
        ])
        progressView.startAnimation(withColor: UalaStyle.colors.cornflower.cgColor)
    }
}
