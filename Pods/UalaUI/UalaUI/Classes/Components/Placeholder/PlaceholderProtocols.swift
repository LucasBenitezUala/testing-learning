import Foundation

public protocol PlaceholderRouterProtocol: AnyObject {
    func didClickButton()
    func secondaryClickButton()
}

public extension PlaceholderRouterProtocol {
    func secondaryClickButton() {}
}

public protocol PlaceholderPresenterProtocol: Presenter {
    func didClickButton()
    func secondaryClickButton()
    func dismiss()
}

public extension PlaceholderPresenterProtocol {
    func secondaryClickButton() {}
    func dismiss() {}
}

public protocol PlaceholderViewProtocol: AnyObject {
    var placeholderPresenter: PlaceholderPresenterProtocol? { get set }
    func setImage(_ image: UIImage?, type: PlaceholderImageType)
    func setTitle(_ title: String)
    func setTitle(_ title: NSMutableAttributedString)
    func customizeTitle(_ style: LabelStyle?, attributes: [UalaAttributedString]?)
    func setBottomLabel(_ text: String)
    func setsubtitle(_ subtitle: String)
    func setsubtitle(_ subtitle: NSMutableAttributedString)
    func customizeSubTitle(_ style: LabelStyle?, attributes: [UalaAttributedString]?)
    func setButton(_ title: String, _ style: ButtonStyle?)
    func setSecondaryButton(_ title: String, _ style: ButtonStyle?)
    func hidePrimaryButton(_ isHidden: Bool)
    func hideSecondaryButton(_ isHidden: Bool)
    func setTitleView(_ title: String)
    func setDescriptionBottomLabel(_ text: String?)
    func updateButtonStatus()
    func setImageSecondaryButton(_ image: UIImage?, side: PlaceholderSide)
}

public extension PlaceholderViewProtocol {
    func setTitle(_ title: NSMutableAttributedString) {}
    func setDescriptionBottomLabel(_ text: String?) {}
    func setImageSecondaryButton(_ image: UIImage?, side: PlaceholderSide) {}
}
