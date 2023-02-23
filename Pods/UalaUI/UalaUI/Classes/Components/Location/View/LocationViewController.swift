//
//  LocationViewController.swift
//  UalaUI
//
//  Created by Ualá on 11/11/21.
//

import UIKit
import Combine
import UalaCore

class LocationViewController: BaseViewController, LocationViewType {

    @IBOutlet public weak var imageView: UIImageView!
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var subtitleLabel: UILabel!
    @IBOutlet public weak var primaryActionButton: UIButton!
    
    weak var locationPresenter: LocationPresenterType?
    public var navigationBarTintColor: UIColor = UalaStyle.colors.blue50
    
    var titleText: String?
    var subtitleText: String?
    var buttonText: String?
    
    init(presenter: LocationPresenterType) {
        locationPresenter = presenter
        super.init(nibName: "LocationViewController", bundle: Bundle(for: LocationViewController.self))
        self.customize(withTitle: nil, subtitle: nil, buttonText: nil)
    }
    
//    For initialization with custom text
    init(presenter: LocationPresenterType, withTitle title: String?, subtitle: String?, buttonText: String?) {
        locationPresenter = presenter
        super.init(nibName: "LocationViewController", bundle: Bundle(for: LocationViewController.self))
        self.customize(withTitle: title, subtitle: subtitle, buttonText: buttonText)
    }
    
    @available (*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        locationPresenter?.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationPresenter?.getCurrentLocationStatus()
    }
    
    public override func customizeNavigation() {
        navigationController?.navigationBar.tintColor = navigationBarTintColor
    }
    
    private func customizeUI() {
        imageView.image = BundleImage(bundle: .Common, named: "ic_location")
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.customize(style: .header)
        titleLabel.text = self.titleText
        
        subtitleLabel.customize(style: .smallSubHeader)
        subtitleLabel.text = self.subtitleText
        subtitleLabel.adjustsFontSizeToFitWidth = true
        
        primaryActionButton.customize(style: UalaStyle.buttons.standardFilledLight)
        primaryActionButton.setTitle(self.buttonText, for: .normal)
        primaryActionButton.addTarget(self, action: #selector(primaryActionButtonPressed), for: .touchUpInside)
    }
    
    @objc private func primaryActionButtonPressed() {
        locationPresenter?.getLocationStatus()
    }
    
    func customize(withTitle title: String?, subtitle: String?, buttonText: String?) {
        self.titleText = title ?? translate("REQUEST_LOCATION_TITLE", from: .Common)
        self.subtitleText = subtitle ?? translate("REQUEST_LOCATION_SUBTITLE", from: .Common)
        self.buttonText = buttonText ?? translate("REQUEST_LOCATION_BUTTON_TITLE", from: .Common)
    }
}
