//
//  Protocols.swift
//  UalaUI
//
//  Created by Luis Perez on 10/06/21.
//

public protocol InformationViewType: AnyObject {
    func updateNavigationTitle(text: String?)
    func updateImage(named: String)
    func updateImage(image: UIImage?)
    func updateTitle(with attributedString: NSAttributedString?)
    func updateSubtitle(with attributedString: NSAttributedString?)
    func updatePrimaryActionTitle(with text: String)
    func removePrimaryActionButton()
    func updateSecundaryActionTitle(with text: String)
    func removeSecundaryActionButton()
    func addBarButton(with imageName: String)
    func updateFooterTitle(text: String?)
    func updateFooterIconImage(with image: String?)
    func updateAnimation(animationName: String?)
    func playAnimation()
    func configureHyperlink()
    func addBackAction()
}

public protocol InformationViewDelegate: AnyObject {
    func viewDidAppear(view: InformationViewType?)
    func viewWillDisappear(view: InformationViewType?)
}

public protocol InformationViewBarButtonAction: AnyObject {
    var imageName: String { get }
    func actionBarButtonPressed(view: BaseViewController?)
}

public protocol InformationViewAction: AnyObject {
    var actionTitle: String { get }
    func actionButtonPressed(view: BaseViewController?)
}

public protocol InformationViewBackButtonAction: AnyObject {
    func actionButtonPressed(view: BaseViewController?)
}

public protocol InformationViewPresenterType: Presenter {
    func setView(view: InformationViewType)
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func primaryActionButtonPressed()
    func secundaryActionButtonPressed()
    func barButtonPressed()
    func subtitleTapPressed()
    func backButtonPressed()
}
