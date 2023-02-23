//
//  HomeNavigationBar.swift
//  UalaFareUI
//
//  Created by Luis Perez on 10/10/22.
//

import UIKit

public final class HomeNavigationBar: UIView {
    private weak var hostingViewController: UIViewController?
    private let appearance: NavigationBarAppearance
    
    private lazy var tabBarButtonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        self.addSubview(stackView)
        
        return stackView
    }()
    
    public init(appearance: NavigationBarAppearance, frame: CGRect = .zero) {
        self.appearance = appearance
        super.init(frame: frame)
        configureHomeBar(appearance: appearance)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = appearance.titleTextColor
        titleLabel.applyTypography(appearance.titleTyphography)
        self.addSubview(titleLabel)

        return titleLabel
    }()
    
    private func configureHomeBar(appearance: NavigationBarAppearance) {
        configureSubviews(appearance: appearance)
    }
    
    private func configureSubviews(appearance: NavigationBarAppearance) {
        self.backgroundColor = appearance.backgroundColor
        configureTitleLabel()
        configureBarButtonStack()
    }
    
    private func configureTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                               constant: -31),
            titleLabel.trailingAnchor.constraint(equalTo: tabBarButtonStack.leadingAnchor)
        ])
    }
    
    private func configureBarButtonStack() {
        NSLayoutConstraint.activate([
            tabBarButtonStack.heightAnchor.constraint(equalToConstant: 48),
            tabBarButtonStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            tabBarButtonStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    public func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
    public func addBarButton(buttons: [UIButton]) {
        buttons.forEach { button in
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 48).isActive = true
            tabBarButtonStack.addArrangedSubview(button)
        }
    }
    
    public func addBarButton(button: UIButton) {
        tabBarButtonStack.addArrangedSubview(button)
    }
    
    public func addFormattedTabBarButton(target: Any?, selector: Selector, for event: UIControl.Event, image: UIImage) {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(target, action: selector, for: event)
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        button.tintColor = appearance.iconTintColor
        button.setImage(image.withRenderingMode(.alwaysTemplate), for: [])
        button.imageEdgeInsets = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        addBarButton(button: button)
    }
    
    public func addInto(hostingViewController: UIViewController) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.hostingViewController = hostingViewController
        hostingViewController.view.addSubview(self)
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: hostingViewController.view.topAnchor),
            self.leadingAnchor.constraint(equalTo: hostingViewController.view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: hostingViewController.view.trailingAnchor),
            self.heightAnchor.constraint(equalToConstant: 132)
        ])
    }
    
    public func viewWillAppear() {
        alterPreviousViewBackIcon()
    }
    
    public func viewDidAppeared() {
        hostingViewController?.navigationController?.navigationBar.isHidden = true
    }
    
    public func viewWillDisappear() {
        hostingViewController?.navigationController?.navigationBar.isHidden = false
    }
    
    private func alterPreviousViewBackIcon() {
        guard let allViewControllers = hostingViewController?.navigationController?.viewControllers,
            allViewControllers.count > 1 else {
            return
        }
        let previousViewController = allViewControllers[allViewControllers.count - 2]
        hostingViewController?.navigationItem.setHidesBackButton(true, animated: true)
        previousViewController.navigationItem.backButtonTitle = ""
    }
}
