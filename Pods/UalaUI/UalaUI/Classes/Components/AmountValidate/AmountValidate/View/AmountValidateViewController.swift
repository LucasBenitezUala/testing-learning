//
//  
//  AmountValidateViewController.swift
//  UalaUI
//
//  Created by Juan Martinez on 7/07/22.
//
//

import UalaUI
import Darwin

public class AmountValidateViewController: BaseViewController, AmountValidateViewProtocol {

    public var viewPresenter: AmountValidatePresenterProtocol?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountField: ExchangeAmountTextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var bottomButtonConstrain: NSLayoutConstraint!
    
    private var paddingDefault = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 5)
    
    fileprivate let defaultFontSize: CGFloat = 12
    
    public override var presenter: Presenter? {
        return viewPresenter
    }
	
    public override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        viewPresenter?.viewDidLoad()
    }	
	
	// MARK: - View - Private Methods
    func customizeUI() {
        
        titleLabel.customize(style: .title)
        titleLabel.textAlignment = .left
        descriptionLabel.customize(style: .subtitle)

        amountField.keyboardType = .numberPad
        amountField.addTarget(self, action: #selector(textfieldChanged(_:)), for: .editingChanged)
        amountField.addTarget(self, action: #selector(textfieldChanged(_:)), for: .editingDidBegin)
        
        bottomButtonConstrain.setKeyboardShowObserver()
        tapToHideKeyboard()
    }
    
    public override func customizeNavigation() {
        navigationController?.navigationBar.backgroundColor = UalaStyle.colors.white
        navigationController?.configNavigationBar(.solid(color: .clear))
    }

    @objc func textfieldChanged(_ textField: ExchangeAmountTextField) {
        
        guard let amount =  amountField.text else { return }
        viewPresenter?.amountTextfieldChanged(with: amount)
    }
    
    @IBAction func clickMainBtn(_ sender: Any) {
        viewPresenter?.didClickButton()
    }
}

// MARK: - View - Public Methods (Through Protocol)
extension AmountValidateViewController {

    public func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    public func setsubtitle(_ subtitle: String) {
        descriptionLabel.text = subtitle
    }
    
    public func customizeAmountField(placeHolder: String, alignment: NSTextAlignment, signLabelText: String, padding: UIEdgeInsets?) {
        amountField.customize(style: .fareCurrency)
        amountField.setPadding(padding: padding ?? paddingDefault)
        amountField.textAlignment = alignment
        amountField.subLabel.font = .regular(size: defaultFontSize)
        amountField.setSignLabel(signLabelText: signLabelText)
        amountField.keyboardType = .numberPad
        amountField.text = placeHolder
    }
    
    public func setMainButton(_ title: String, _ style: ButtonStyle, isEnabled: Bool) {
        continueButton.setTitle(title, for: .normal)
        continueButton.customize(style: style)
        continueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        changeButtonStatus(status: isEnabled)
    }
    
    public func setAmountText(_ txtAmount: String, isError: Bool) {
        
        amountField.setError(isError: isError, text: txtAmount)
        amountField.textColor = isError ? UalaStyle.colors.fareTextErrorColor : UalaStyle.colors.fareTextMainColor
    }
    
    public func changeButtonStatus(status: Bool) {
        continueButton.isEnabled = status
    }
    
    public func setPlaceHolder(_ placeHolder: String) {
        amountField.text = placeHolder
        amountField.textColor = UalaStyle.colors.grey90
    }
    
    public func getTextFieldValue() -> Double? {
        guard let value = amountField.text else {
            return nil
        }
        return value.currencyInputFormatting().convertCurrencyToDouble()
    }
    
    public func showLoading() {
        showLoadingView()
    }
    
    public func hideLoading() {
        hideLoadingView()
    }
}
