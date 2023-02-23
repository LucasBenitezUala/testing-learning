//
//  BasicInfoViewController.swift
//
//  Created by Monserrath Castro on 21/04/22.
//  Copyright © 2022 Ualá. All rights reserved.
//

import UIKit

public class BasicInfoViewController: BaseViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    public var basicInfoViewPresenter: BasicInfoViewPresenterProtocol?

    public override var presenter: Presenter? {
        return basicInfoViewPresenter
    }

    public init(basicInfoViewPresenter: BasicInfoViewPresenterProtocol) {
        self.basicInfoViewPresenter = basicInfoViewPresenter
        super.init(nibName: String(describing: BasicInfoViewController.self),
                   bundle: Bundle(for: BasicInfoViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	public override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        basicInfoViewPresenter?.getViewModel()
    }
	
	// MARK: - View - Private Methods
    private func customizeUI() {
        titleLabel.customize(style: .mediumBlackishLeft(size: 22))
        titleLabel.text = nil
        descriptionLabel.customize(style: .regularFarePrimaryLeft(size: 14))
        configureBackground()
    }

    private func configureBackground() {
        if let backgroundColor = basicInfoViewPresenter?.getBackgroundColor() {
            view.backgroundColor = backgroundColor
            self.backgroundImage.image = nil
        } else if let imageName = basicInfoViewPresenter?.getBackgroundImageName(),
                  let bundle = basicInfoViewPresenter?.getBackgroundImageBundle() {
            let backgroundImage = BundleImage(bundle: bundle, named: imageName)
            let defaultImage = BundleImage(bundle: .Common, named: "background_blue_drop_light")
            self.backgroundImage.image = backgroundImage ?? defaultImage
        } else {
            view.backgroundColor = UalaStyle.colors.background
            self.backgroundImage.image = nil
        }
    }

    public override func customizeNavigation() {
        super.customizeNavigation()
        navigationController?.configureNavigationCleanBar()
    }
}

extension BasicInfoViewController: BasicInfoViewProtocol {
    public func setTitle(with text: String?) {
        titleLabel.text = text
    }

    public func setDescription(with text: String?) {
        descriptionLabel.text = text
    }
}
