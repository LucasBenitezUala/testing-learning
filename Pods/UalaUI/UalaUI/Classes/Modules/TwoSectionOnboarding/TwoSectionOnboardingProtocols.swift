//
//  TwoSectionOnboardingProtocols.swift
//  UalaUI
//
//  Created by Laura Krayacich on 07/04/2021.
//

import Foundation

// MARK: Presenter -
@objc public protocol TwoSectionOnboardingPresenterProtocol: AnyObject {
    func didClickMainButton()
    @objc optional func didClickSecondButton(channel: String)
    @objc optional func didShowHelp()
}

// MARK: View -
public protocol TwoSectionOnboardingViewProtocol: AnyObject {
    var twoSectionOnboardingPresenter: TwoSectionOnboardingPresenter? { get set }
}

// MARK: Router -
@objc public protocol TwoSectionOnboardingRouterProtocol: AnyObject {
    func pushNextViewController()
    @objc optional func pushNextViewController(fee: Int, isFree: Bool, totalFee: Double)
    @objc optional func pushCreatePin(isReprinted: Bool)
    @objc optional func navigateToFee()
    @objc optional func pushTokenAmountViewController(channel: String)
    @objc optional func didShowHelp()
}
