import Foundation
import UalaCore

public class AmountTextField: BancarTextField {

    var labelStyle: LabelStyle?
    
    private var subLabelText: String?
    private var currencyColor: UIColor = UalaStyle.colors.blue50
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        customizeLabel()
        setInitialValue()
        keyboardType = .numberPad
    }

    override public func customize(style: BancarTextFieldStyle) {
        font = style.font
        tintColor = style.tintColor
        textColor = style.textColor
        textAlignment = style.textAlignment
        lineColor = style.lineColor
        placeholderActiveFont = style.placeholderActiveFont
        placeholderActiveColor = style.placeholderActiveColor
        activeLineColor = style.activeLineColor
        backupActiveLineColor = style.activeLineColor
        backupLineColor = style.lineColor
        currencyColor = style.currencySignColor
        
        setInitialValue()
    }
    
    public func customizeSubLabel(text: String? = nil, style: LabelStyle = .regularWarmGreyFiveLeft(size: 13)) {
        subLabelText = text
        self.labelStyle = style
        subLabel.text = text
        subLabel.customize(style: style)
    }
    
    override public func setError(isError: Bool) {
        guard let style = self.style, let labelStyle = self.labelStyle else { return }
        super.setError(isError: isError)
        subLabel.customize(style: isError ? .error : labelStyle)
        subLabel.text = isError ? nil : subLabelText
        self.customize(style: isError ? .error : style)
    }
    
    public func setError(isError: Bool, text: String) {
        self.setError(isError: isError)
        subLabel.text = text
    }
    
    private func setInitialValue() {
        attributedText = attributedAmount(value: 0)
    }
    
    private func attributedAmount(value: Double) -> NSMutableAttributedString {
        let range = NSRange(location: 0, length: 1)
        let attributedValueText = NSMutableAttributedString(string: String.strCurrency(from: value, 0))
        attributedValueText.addAttributes([NSAttributedString.Key.foregroundColor: currencyColor], range: range)
        
        return attributedValueText
    }
}

extension AmountTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let current = (textField.text ?? "") as NSString
        let numbers = current.replacingCharacters(in: range, with: string).numbers
        let value = Double(numbers) ?? 0
        
        textField.attributedText = attributedAmount(value: value)
        return false
    }

    public var value: Double {
        return Double(self.text?.numbers ?? "0") ?? 0
    }
}
