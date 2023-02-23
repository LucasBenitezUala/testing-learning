//
//  CustomPopUpViewController.swift
//  UalaExchange
//
//  Created by Nahuel Herrera on 13/10/2021.
//

import UIKit
import UalaUI
import UalaCore

class CustomPopUpViewController: BaseViewController, CustomPopUpViewProtocol, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var primaryButton: UIButton!
    @IBOutlet weak var secondaryButton: UIButton!
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var descriptionContainerView: UIView!
    @IBOutlet weak var primaryContainerView: UIView!

    @IBOutlet weak var secundaryContainerView: UIView!
    
    var presenterCustomPopUP: CustomPopUpPresenterProtocol?
    private let containerViewCornerRadius: CGFloat = 3
    private let containerViewShadowRadius: CGFloat = 10
    private let containerViewShadowOpacity: Float = 0.90
    private let containerViewShadowOffSet: CGSize = CGSize(width: 3, height: 10)

    required init(presenter: CustomPopUpPresenterProtocol) {
        self.presenterCustomPopUP = presenter
        super.init(nibName: "CustomPopUpViewController", bundle: Bundle(for: CustomPopUpViewController.self))
        self.transitioningDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareToPresent()
        customize()
        buttonTargets()
        presenterCustomPopUP?.viewWillAppear()
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
    
    func setTitleText(_ title: NSAttributedString) {
        titleLabel.attributedText = title
    }
    
    func setDescriptionText(_ description: NSAttributedString) {
        descriptionLabel.attributedText = description
    }
    
    func setPrimaryButtonText(text: String, style: ButtonStyle) {
        primaryButton.setTitle(text, for: .normal)
        primaryButton.customize(style: style)
    }
    
    func setSecondaryButton(text: String, style: ButtonStyle) {
        secondaryButton.setTitle(text, for: .normal)
        secondaryButton.customize(style: style)
    }
        
    func hideImageView(value: Bool) {
        imageContainerView.isHidden = value
    }
    
    func hideTitleLabel(value: Bool) {
        titleContainerView.isHidden = value
    }
    
    func hideDescriptionLabel(value: Bool) {
        descriptionContainerView.isHidden = value
    }
    
    func hidePrimaryButton(value: Bool) {
        primaryContainerView.isHidden = value
    }
    
    func hideSecondaryButton(value: Bool) {
        secundaryContainerView.isHidden = value
    }
    
    @objc func primaryButtonClickAction() {
        presenterCustomPopUP?.actionPrimaryButton()
    }
    
    @objc func secondaryButtonClickAction() {
        presenterCustomPopUP?.actionSecundaryButton()
    }
    
    private func customize() {
        primaryButton.customize(style: UalaStyle.buttons.standardOutlineLight)
        secondaryButton.customize(style: UalaStyle.buttons.standardUnfilledLight)
        containerView.layer.cornerRadius = containerViewCornerRadius
        containerView.layer.shadowColor = UalaStyle.colors.grey20.cgColor
        containerView.layer.shadowOffset = containerViewShadowOffSet
        containerView.layer.shadowRadius = containerViewShadowRadius
        containerView.layer.shadowOpacity = containerViewShadowOpacity
    }
    
    private func buttonTargets() {
        secondaryButton.addTarget(self, action: #selector(secondaryButtonClickAction), for: .touchUpInside)
        primaryButton.addTarget(self, action: #selector(primaryButtonClickAction), for: .touchUpInside)
    }
    
    private func prepareToPresent() {
        let windowWidth: CGFloat = UIScreen.main.bounds.size.width
        let windowHeight: CGFloat = UIScreen.main.bounds.size.height
        view.frame = CGRect(
            x: 0,
            y: 0,
            width: windowWidth,
            height: windowHeight
        )
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = TransitionFromCenter()
        animator.isPresenting = true
        return animator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = TransitionFromCenter()
        animator.isPresenting = false
        return animator
    }
}
