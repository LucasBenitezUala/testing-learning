import UIKit

public class InfoFieldView: BaseFieldView {
    @IBOutlet weak var fieldLabel: UILabel! {
        didSet {
            fieldLabel.numberOfLines = UIDevice.isLowerResolutionDevice ? 2 : 1
        }
    }
    @IBOutlet weak var valueLabel: UILabel! {
        didSet {
            valueLabel.numberOfLines = UIDevice.isLowerResolutionDevice ? 2 : 1
        }
    }
    @IBOutlet weak var bottomLine: UIView!
    
    @IBInspectable public var fieldTextColor: UIColor? {
        didSet {
            fieldLabel.textColor = fieldTextColor
        }
    }
    
    @nonobjc public init(_ field: String, _ value: String?, _ color: UIColor? = nil, _ hideBottomLine: Bool = false, highlight: Bool = false) {
        super.init(frame: .zero)        
        fieldLabel.text = field
        valueLabel.text = value
        bottomLine.isHidden = hideBottomLine
        
        if let color = color {
            valueLabel.textColor = color
        }
        
        if highlight {
            fieldLabel.font = .bold(size: 14)
            fieldLabel.textColor = UalaStyle.colors.grey90
            valueLabel.font = .bold(size: 14)
            valueLabel.textColor = UalaStyle.colors.grey90
        }
    }
    
    @nonobjc public init(_ field: String, fieldFont: UIFont, _ color: UIColor? = nil, _ hideBottomLine: Bool = false) {
        super.init(frame: .zero)
        valueLabel.isHidden = true

        fieldLabel.text = field
        fieldLabel.font = fieldFont
        if let color = color {
            fieldLabel.textColor = color
        }
        
        bottomLine.isHidden = hideBottomLine
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
