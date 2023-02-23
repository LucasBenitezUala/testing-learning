//
//  AccountInformationView.swift
//  UalaUI
//
//  Created by Ualá on 13/05/2022.
//

import UIKit
import UalaUtils

public protocol AccountInformationViewDelegate: AnyObject {
    func didTapCard()
}

public final class AccountInformationView: UIView {
    lazy var containerView = UIView()
    lazy var titleLabel = UILabel()
    lazy var currencyLabel = UIButton()
    lazy var balanceLabel = UILabel()
    
    public weak var delegate: AccountInformationViewDelegate?
    
    @objc func didTapContainerView() {
        delegate?.didTapCard()
    }
    
    public func setup(input: AccountInformationViewInput) {
        configureContainerView(with: input)
        configureTitleLabel(with: input)
        configureCurrencyLabel(with: input)
        configureBalanceLabel(with: input)
        setupConstraints()
    }
    
    private func configureContainerView(with input: AccountInformationViewInput) {
        containerView.backgroundColor = input.backgroundColor
        containerView.cornerRadius(radius: 10)
        addSubview(containerView)
        containerView.anchor(top: self.layoutMarginsGuide.topAnchor,
                             leading: self.safeAreaLayoutGuide.leadingAnchor,
                             paddingLeading: 12,
                             bottom: self.layoutMarginsGuide.bottomAnchor,
                             paddingBottom: 12,
                             trailling: self.safeAreaLayoutGuide.trailingAnchor,
                             paddingTrailling: 12)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapContainerView))
        containerView.addGestureRecognizer(gesture)
    }
    
    private func configureTitleLabel(with input: AccountInformationViewInput) {
        titleLabel.text = input.textTitle
        titleLabel.customize(style: input.titleStyle)
        titleLabel.numberOfLines = 2
        containerView.addSubview(titleLabel)
    }
    
    private func configureCurrencyLabel(with input: AccountInformationViewInput) {
        currencyLabel.setTitle(input.textCurrency, for: .normal)
        currencyLabel.backgroundColor = UalaColor().whiteBlue10
        currencyLabel.titleLabel?.font = .regular(size: 11)
        currencyLabel.setTitleColor(UalaColor().blue50, for: .normal)
        currencyLabel.cornerRadius(radius: 10)
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currencyLabel.isUserInteractionEnabled = false
        containerView.addSubview(currencyLabel)
    }
    
    private func configureBalanceLabel(with input: AccountInformationViewInput) {
        balanceLabel.customize(style: input.balanceStyle)
        let balance = String.strCurrency(from: input.textBalance)
        balanceLabel.attributedText = balance.attributedStringWithColorSize(
            color: UalaStyle.colors.fareTextMainColor,
            size: 14,
            lengthToAttribute: 2,
            font: UIFont.semiBold(size: 14)
        )
        containerView.addSubview(balanceLabel)
    }
    
    private func setupConstraints() {
        titleLabel.centerY(inView: containerView)
        currencyLabel.centerY(inView: titleLabel)
        balanceLabel.centerY(inView: titleLabel)
        titleLabel.anchor(leading: containerView.safeAreaLayoutGuide.leadingAnchor,
                          paddingLeading: 32,
                          trailling: currencyLabel.safeAreaLayoutGuide.leadingAnchor,
                          paddingTrailling: 12)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        currencyLabel.anchor(trailling: balanceLabel.safeAreaLayoutGuide.leadingAnchor, paddingTrailling: 8)
        balanceLabel.anchor(trailling: containerView.safeAreaLayoutGuide.trailingAnchor, paddingTrailling: 32)
    }
}
