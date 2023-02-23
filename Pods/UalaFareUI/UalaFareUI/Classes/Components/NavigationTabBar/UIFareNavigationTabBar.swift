//
//  UIFareNavigationTabBar.swift
//  UalaFareUI
//
//  Created by Luis Perez on 29/09/22.
//

import UIKit

public enum UIFareTabBarControllerCentralButtonType: Equatable {
    case standart
    case rounded(icon: UIImage)
}

public protocol UIFareTabBarControllerConfiguration {
    var font: UIFont { get }
    var iconTintColor: UIColor { get }
    var textColor: UIColor { get }
    var textVerticalPositionAdjustment: CGFloat { get }
}

public protocol UIFareTabBarControllerTheme {
    var normalConfiguration: UIFareTabBarControllerConfiguration { get }
    var selectedConfiguration: UIFareTabBarControllerConfiguration { get }
    var centralButtonTheme: ButtonTheme { get }
    var backgroundColor: UIColor { get }
}

public struct UIFareTabBarItem {
    public let viewController: UIViewController
    public let selectedStatusImage: UIImage
    public let deselectedStatusImage: UIImage
    public let title: String
    
    public init(viewController: UIViewController, selectedStatusImage: UIImage, deselectedStatusImage: UIImage, title: String) {
        self.viewController = viewController
        self.selectedStatusImage = selectedStatusImage
        self.deselectedStatusImage = deselectedStatusImage
        self.title = title
    }
}

open class UIFareTabBarController: UITabBarController {
    private lazy var customCentralButton: UIFareButton = {
        let button = UIFareButton(theme: theme.centralButtonTheme, frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(centralButtonPressed),
                         for: .touchUpInside)
        return button
    }()
    
    private let theme: UIFareTabBarControllerTheme
    private var tabItems: [UIFareTabBarItem]
    private let tabBarKey = "tabBar"
    private let centralButtonType: UIFareTabBarControllerCentralButtonType
    private var centralItemIndex: Int {
        tabItems.count / 2
    }
    
    public init(theme: UIFareTabBarControllerTheme, items: [UIFareTabBarItem], centralButtonType: UIFareTabBarControllerCentralButtonType) {
        self.theme = theme
        self.tabItems = items
        self.centralButtonType = centralButtonType
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureViewControllers()
        buildCentralButtonIfNeeded()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTabBarHeight()
    }
    
    private func configureTabBar() {
        setValue(UIFareTabBar(theme: MainThemeManager.shared,
                              shouldAddCentralButtonShape: shouldEnhanceCentralButton()),
                 forKey: tabBarKey)
        let tabBarAppearance = tabBarAppearance()
        
        self.tabBar.standardAppearance = tabBarAppearance
        
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
    
    private func tabBarAppearance() -> UITabBarAppearance {
        let tabBarItemAppearance = tabBarItemAppearance()
        let tabBarAppearance = UITabBarAppearance()
        
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor = theme.backgroundColor
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance
        
        return tabBarAppearance
    }
    
    private func tabBarItemAppearance() -> UITabBarItemAppearance {
        let tabBarItemAppearance = UITabBarItemAppearance()
        
        tabBarItemAppearance.normal.titleTextAttributes = [
            .font: theme.normalConfiguration.font,
            .foregroundColor: theme.normalConfiguration.textColor
        ]
        tabBarItemAppearance.selected.titleTextAttributes = [
            .font: theme.selectedConfiguration.font,
            .foregroundColor: theme.selectedConfiguration.textColor
        ]
        tabBarItemAppearance.normal.iconColor = theme.normalConfiguration.iconTintColor
        tabBarItemAppearance.selected.iconColor = theme.selectedConfiguration.iconTintColor
        tabBarItemAppearance.normal.titlePositionAdjustment.vertical = theme.normalConfiguration.textVerticalPositionAdjustment
        tabBarItemAppearance.selected.titlePositionAdjustment.vertical = theme.normalConfiguration.textVerticalPositionAdjustment
        
        return tabBarItemAppearance
    }
    
    private func updateTabBarHeight() {
        tabBar.frame.size.height = tabBarHeight()
        tabBar.frame.origin.y = view.frame.height - tabBarHeight()
    }
    
    private func tabBarHeight() -> CGFloat {
        let bottomInset = self.view.safeAreaInsets.bottom
        let desiredSize: CGFloat = 72
        return desiredSize + bottomInset
    }
    
    private func configureViewControllers() {
        let controllersToDisplay: [UIViewController] = tabItems.enumerated().map { item in
            let controller = item.element.viewController
            
            // Since we are doing a custom button, we need to remove title and image from the tab item
            if shouldEnhanceCentralButton() && item.offset == centralItemIndex {
                controller.tabBarItem.title = nil
                controller.tabBarItem.image = nil
            } else {
                controller.tabBarItem.title = item.element.title
                controller.tabBarItem.selectedImage = ImageResizer.resizeImage(24,
                                                                               image: item.element.selectedStatusImage,
                                                                               opaque: false)
                controller.tabBarItem.image = ImageResizer.resizeImage(24,
                                                                       image: item.element.deselectedStatusImage,
                                                                       opaque: false)
                controller.tabBarItem.imageInsets = UIEdgeInsets(top: -6.5,
                                                                 left: 0,
                                                                 bottom: 5,
                                                                 right: 0)
            }
            
            return controller
        }
        
        self.viewControllers = controllersToDisplay
    }
    
    private func shouldEnhanceCentralButton() -> Bool {
        return centralButtonType != .standart
        && tabItems.count > 2
        && tabItems.count % 2 == 1
    }
    
    private func buildCentralButtonIfNeeded() {
        if shouldEnhanceCentralButton() && customCentralButton.superview == nil {
            switch centralButtonType {
            case .rounded(icon: let icon):
                customCentralButton.setImage(icon, for: [])
                tabBar.addSubview(customCentralButton)
                
                NSLayoutConstraint.activate([
                    customCentralButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: 8),
                    customCentralButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
                    customCentralButton.widthAnchor.constraint(equalToConstant: 48),
                    customCentralButton.heightAnchor.constraint(equalToConstant: 48)
                ])
            case .standart:
                return
            }
        }
    }
        
    @objc private func centralButtonPressed() {
        selectedIndex = centralItemIndex
    }
    
    private var bounceAnimation: CAKeyframeAnimation = {
            let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
            bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
            bounceAnimation.duration = TimeInterval(0.3)
            bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
            return bounceAnimation
    }()
    
    private func animateView(_ view: UIView) {
        UIView.animate(withDuration: 0.15,
                       delay: 0, options: .curveEaseIn) {
            view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           options: .curveEaseOut) {
                view.transform = .identity
            }
        }
    }
    
    // MARK: This function is required to animate regular tab bar items, if desing approves can can uncomment this and animate the items.
//    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        guard let idx = tabBar.items?.firstIndex(of: item),
//              tabBar.subviews.count > idx + 1,
//              let imageView = tabBar.subviews[idx + 1].subviews.compactMap({ $0 as? UIImageView }).first else {
//            return
//        }
//        animateView(imageView)
//    }
}
