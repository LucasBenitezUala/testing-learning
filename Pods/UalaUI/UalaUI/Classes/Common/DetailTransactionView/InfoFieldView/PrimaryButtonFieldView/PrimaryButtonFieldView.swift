import UIKit

public class PrimaryButtonFieldView: BaseFieldView, Actionable {
    
    @IBOutlet weak public var button: UIButton!
    let detailAction: DetailViewAction?
    public weak var delegate: ActionDelegate?
    
    public enum ImagePosition {
        case left
        case right
    }
    
    public init(_ title: String, _ detailAction: DetailViewAction? = nil, style: ButtonStyle = UalaStyle.buttons.standardFilledLight, image: UIImage? = nil, position: ImagePosition = .left) {
        self.detailAction = detailAction
        super.init(frame: .zero)
        button.setTitle(title, for: .normal)
        button.customize(style: style)
        button.setImage(image, for: .normal)
        let insetSize: CGFloat = 20
        let imageRightInset: CGFloat = position == .left ? insetSize : -insetSize
        let semanticContent: UISemanticContentAttribute = position == .left ? .forceLeftToRight : .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: imageRightInset)
        button.semanticContentAttribute = semanticContent
    }
    
    @IBAction func didClick(_ sender: Any) {
        if let action = detailAction {
            delegate?.didClickButton(action)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
