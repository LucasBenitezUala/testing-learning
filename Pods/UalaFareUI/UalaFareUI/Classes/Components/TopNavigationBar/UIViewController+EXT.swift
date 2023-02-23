//
//  UIViewController+EXT.swift
//  UalaFareUI
//
//  Created by Luis Perez on 10/10/22.
//

import UIKit

public enum NavigationBarType {
    case lightBackground(topImage: UIImage? = nil)
    case darkBackground(topImage: UIImage? = nil)
    case home
    
    internal var topImage: UIImage? {
        switch self {
        case .lightBackground(let topImage):
            return topImage
        case .darkBackground(let topImage):
            return topImage
        default:
            return nil
        }
    }
}

public extension UIViewController {
    var homeNavigationBar: HomeNavigationBar? {
        if let bar = findSubview(ofType: HomeNavigationBar.self, in: self.view) {
            return bar
        }
        return nil
    }
    
    func configureNavigationBar(type: NavigationBarType, theme: Theme = MainThemeManager.shared) {
        let baseAppearance = theme.navigationBarAppearance(barType: type)
        removeBackTitleFromPreviousController()
        navigationItem.titleView = nil
        navigationItem.backButtonTitle = ""
        
        switch type {
        case .lightBackground, .darkBackground:
            self.navigationController?.navigationBar.tintColor = baseAppearance.iconTintColor
            self.navigationItem.standardAppearance = darkBarAppearance(baseAppearance: baseAppearance)
            self.navigationItem.compactAppearance = darkBarAppearance(baseAppearance: baseAppearance)
            self.navigationItem.scrollEdgeAppearance = darkBarAppearance(baseAppearance: baseAppearance)
            
            guard let topImage = type.topImage else {
                return
            }
            navigationItem.titleView = titleView(image: topImage)
            
        case .home:
            navigationController?.navigationBar.tintColor = baseAppearance.iconTintColor
            navigationItem.standardAppearance = clearBarAppearance()
            navigationItem.compactAppearance = clearBarAppearance()
            navigationItem.scrollEdgeAppearance = clearBarAppearance()
            if homeNavigationBar != nil {
                return
            }
            let homeNavigationBar = HomeNavigationBar(appearance: baseAppearance)
            homeNavigationBar.addInto(hostingViewController: self)
        }
    }
    
    func formattedBarButtonItem(icon: DefaultIcons, target: Any?, action: Selector?) -> UIBarButtonItem {
        guard let image = UIImage(withAsset: icon) else {
            return UIBarButtonItem(image: nil, style: .plain, target: target, action: action)
        }
        return formattedBarButtonItem(image: image, target: target, action: action)
    }
    
    func formattedBarButtonItem(image: UIImage, target: Any?, action: Selector?) -> UIBarButtonItem {
        let formattedImage = ImageResizer.resizeImage(24,
                                                      image: image,
                                                      opaque: false)
        return  UIBarButtonItem(image: formattedImage, style: .plain, target: target, action: action)
    }
    
    private func darkBarAppearance(baseAppearance: NavigationBarAppearance) -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        let backImageIcon = DefaultIcons.left
        
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = baseAppearance.backgroundColor
        appearance.titleTextAttributes = [
            .font: titleFont(style: baseAppearance.titleTyphography),
            .foregroundColor: baseAppearance.titleTextColor
        ]
        
        guard let formattedImage = UIImage(withAsset: backImageIcon) else {
            return appearance
        }
        
        appearance.setBackIndicatorImage(formattedImage,
                                         transitionMaskImage: formattedImage)
        
        return appearance
    }
    
    private func clearBarAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        let backImageIcon = DefaultIcons.left
        
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]
        
        guard let formattedImage = UIImage(withAsset: backImageIcon) else {
            return appearance
        }
        
        appearance.setBackIndicatorImage(formattedImage,
                                         transitionMaskImage: formattedImage)
        
        return appearance
    }
    
    private func titleFont(style: TypographyStyle) -> UIFont {
        guard let font = UIFont(family: style.attributes.fontFamily,
                                weight: style.attributes.fontWeight,
                                size: style.attributes.fontSize) else {
            return UIFont.systemFont(ofSize: style.attributes.fontSize.rawValue)
        }
        
        return font
    }
    
    private func findSubview<T>(ofType: T.Type, in view: UIView) -> T? {
        for subview in view.subviews {
            if let result = subview as? T {
                return result
            } else if let result = findSubview(ofType: T.self, in: subview) {
                return result
            }
        }
        return nil
    }
    
    private func titleView(image: UIImage) -> UIView {
        let containerView = UIView()
        let imageView = UIImageView()
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        containerView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 200),
            containerView.heightAnchor.constraint(equalToConstant: 44),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        return imageView
    }
    
    private func removeBackTitleFromPreviousController() {
        guard let navigationController = self.navigationController,
              navigationController.viewControllers.count > 1 else {
            return
        }
        
        navigationController.viewControllers[navigationController.viewControllers.count - 2].navigationItem.backButtonTitle = ""
    }
}
