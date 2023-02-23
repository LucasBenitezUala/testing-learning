//
//  
//  AmountValidateProtocols.swift
//  UalaUI
//
//  Created by Juan Martinez on 7/07/22.
//
//

import UalaUI

public protocol AmountValidateViewProtocol: AnyObject {
	var viewPresenter: AmountValidatePresenterProtocol? { get set }
    
    func setTitle(_ title: String)
    func setsubtitle(_ subtitle: String)
    func customizeAmountField(placeHolder: String, alignment: NSTextAlignment, signLabelText: String, padding: UIEdgeInsets?)
    func setAmountText(_ txtAmount: String, isError: Bool)
    func setMainButton(_ title: String, _ style: ButtonStyle, isEnabled: Bool)
    func changeButtonStatus(status: Bool)
    func setPlaceHolder(_ placeHolder: String)
    func getTextFieldValue() -> Double?
    func showLoading()
    func hideLoading()
}

public protocol AmountValidatePresenterProtocol: Presenter {
    func amountTextfieldChanged(with amount: String)
    func didClickButton()
    func dismiss()
}

public extension AmountValidatePresenterProtocol {
    func dismiss() {}
}
