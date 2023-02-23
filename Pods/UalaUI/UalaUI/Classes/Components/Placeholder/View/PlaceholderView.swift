import UIKit
import UalaCore

public enum PlaceholderImageType {
    case square
    case rectangle
}

public class PlaceholderView: BaseViewController, PlaceholderViewProtocol {
    
    public var placeholderPresenter: PlaceholderPresenterProtocol?
    public var hideDismissBtn = true
    public var isEmbedInView: Bool = false
    let imgRectangleHeight: CGFloat = 217.0
    public var navigationTintColor: UIColor?
    public var translucentNavigation: Bool = true
    public var navigationTitle: String?
    public var statusBarStyle: UIStatusBarStyle = .default
    
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var dismissImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var secondaryButton: UIButton!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var dismissImgTop: NSLayoutConstraint!
    @IBOutlet weak var descriptionBottomLabel: UILabel!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationBarHidden = !isEmbedInView
        dismissBtn.isHidden = hideDismissBtn
        dismissImage.isHidden = hideDismissBtn
        dismissImage.image = CommonImage(named: "back_blue")
        title = translate("CREDITS", from: .Loans)
        placeholderPresenter?.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            // Safe area constraints already set
        } else {
            dismissImgTop.constant = 20
        }
        setupAccessibilityIdentifier()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        placeholderPresenter?.viewWillDisappear()
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    public func setImage(_ image: UIImage?, type: PlaceholderImageType) {
        imageView.image = image
        
        if type == .rectangle {
            self.imageHeight.constant = imgRectangleHeight
        }
    }
    
    public func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    public func setTitle(_ title: NSMutableAttributedString) {
        titleLabel.attributedText = title
    }
    
    public func customizeTitle(_ style: LabelStyle?, attributes: [UalaAttributedString]?) {
        customizeLabel(label: titleLabel, style, attributes: attributes)
    }
    
    private func customizeLabel(label: UILabel, _ style: LabelStyle?, attributes: [UalaAttributedString]?) {
        
        if let style = style, attributes == nil {
            label.customize(style: style)
        }
        
        if let attributes = attributes, style == nil {
            label.setAttributes(elements: attributes)
        }
        
        guard let style = style, let attributes = attributes else {
            return
        }
        
        label.customize(style: style, with: attributes)
    }
    
    public func setsubtitle(_ subtitle: String) {
        subtitleLabel.text = subtitle
    }
    
    public func setsubtitle(_ subtitle: NSMutableAttributedString) {
        subtitleLabel.attributedText = subtitle
    }
    
    public func customizeSubTitle(_ style: LabelStyle?, attributes: [UalaAttributedString]?) {
        customizeLabel(label: subtitleLabel, style, attributes: attributes)
    }
    
    public func setBottomLabel(_ text: String) {
        bottomLabel.text = text
        bottomLabel.isHidden = false
    }
    
    public func setButton(_ title: String, _ style: ButtonStyle?) {
        actionButton.setTitle(title, for: .normal)
        guard let style = style else { return }
        actionButton.customize(style: style)
        actionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    public override func customizeNavigation() {
        super.customizeNavigation()
        navigationController?.navigationBar.isTranslucent = translucentNavigation
        translucentNavigation ? navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default) : navigationController?.configNavigationBar(.gradient(on: nil))
        if let navigationTintColor = navigationTintColor {
            navigationController?.navigationBar.tintColor = navigationTintColor
            navigationController?.setupTitle(color: navigationTintColor)
        }
        if let navigationTitle = navigationTitle {
            self.title = navigationTitle
        }
    }
    
    public func setSecondaryButton(_ title: String, _ style: ButtonStyle?) {
        secondaryButton.isHidden = false
        secondaryButton.setTitle(title, for: .normal)
        guard let style = style else { return }
        secondaryButton.customize(style: style)
        secondaryButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    public func setDescriptionBottomLabel(_ text: String?) {
        guard let text = text else { return }
        descriptionBottomLabel.customize(style: .regularBlackCenter(size: 14))
        descriptionBottomLabel.text = text
        descriptionBottomLabel.isHidden = false
    }
    
    @IBAction func didClickButton(_ sender: Any) {
        placeholderPresenter?.didClickButton()
    }
    
    @IBAction func secondaryButtonDidClick(_ sender: Any) {
        placeholderPresenter?.secondaryClickButton()
    }
    
    @IBAction func didClickDismissButton() {
        placeholderPresenter?.dismiss()
    }
    
    public func hidePrimaryButton(_ isHidden: Bool) {
        actionButton.isHidden = isHidden
    }
    
    public func hideSecondaryButton(_ isHidden: Bool) {
        secondaryButton.isHidden = isHidden
    }
    
    public func setTitleView(_ title: String) {
        self.title = title
    }
    
    public func updateButtonStatus() {
        buttonsStackView.heightAnchor.constraint(equalToConstant: 0).isActive = true
    }
    
    public func setImageSecondaryButton(_ image: UIImage?, side: PlaceholderSide) {
        guard let imageBtn = image else { return }
        secondaryButton.setImage(imageBtn, for: .normal)
        let insetSize: CGFloat = 20
        secondaryButton.tintColor = .white
        let imageRightInset: CGFloat = side == .left ? insetSize : -insetSize
        let semanticContent: UISemanticContentAttribute = side == .left ? .forceLeftToRight : .forceRightToLeft
        secondaryButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: imageRightInset)
        secondaryButton.semanticContentAttribute = semanticContent
      }
}

// MARK: Accessibility
private extension PlaceholderView {
    
    func setupAccessibilityIdentifier() {
        dismissBtn.accessibilityIdentifier = PlaceholderAccessibility.dismissBtn.rawValue
        dismissImage.accessibilityIdentifier = PlaceholderAccessibility.dismissImage.rawValue
        imageView.accessibilityIdentifier = PlaceholderAccessibility.imageView.rawValue
        imageView.isAccessibilityElement = true
        titleLabel.accessibilityIdentifier = PlaceholderAccessibility.titleLabel.rawValue
        subtitleLabel.accessibilityIdentifier = PlaceholderAccessibility.subtitleLabel.rawValue
        actionButton.accessibilityIdentifier = PlaceholderAccessibility.actionButton.rawValue
        secondaryButton.accessibilityIdentifier = PlaceholderAccessibility.secondaryButton.rawValue
    }
}
