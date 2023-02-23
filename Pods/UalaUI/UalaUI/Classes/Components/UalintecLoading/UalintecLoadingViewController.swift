//
//  UalintecLoadingViewController.swift
//  UalaUI
//
//  Created by Nahuel Herrera on 04/03/2022.
//

import UIKit
import UalaCore

public class UalintecLoadingViewController: UIViewController {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    public var time: Double = 1.0
    private let loadingOption: LoadingOption
    
    public init(loadingOption: LoadingOption = UalintecLoadingOption()) {
        self.loadingOption = loadingOption
        super.init(nibName: String(describing: UalintecLoadingViewController.self),
                   bundle: Bundle(for: UalintecLoadingViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
    }
    
    private func customizeUI() {
        backgroundImage.image = loadingOption.backgroundImage
        logoImage.image = loadingOption.iconImage
    }
    
    public func onFinishCounter(completion: @escaping () -> Void) {
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: self.time, animations: {
                self.logoImage.alpha = 0
                self.logoImage.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.backgroundImage.alpha = 0
                self.backgroundImage.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: { _ in
                self.dismiss(animated: false) {
                    completion()
                }
            })
        }
    }
}
