//
//  UalaButtonTheme.swift
//  UalaDSDemo
//
//  Created by Luis Perez on 04/07/22.
//

import UIKit

public enum UIFareButtonType: Equatable {
    case primary(size: ComponentSize, isOnDarkBackground: Bool = false)
    case seccondary(size: ComponentSize, isOnDarkBackground: Bool = false)
    case textOnly(size: ComponentSize, isOnDarkBackground: Bool = false)
    case iconOnly(isOnDarkBackground: Bool = false)
    case tabBar
    case link
    
    public var size: ComponentSize {
        switch self {
        case .primary(let size, _):
            return size
        case .seccondary(let size, _):
            return size
        case .textOnly(let size, _):
            return size
        case .iconOnly:
            return .large
        case .tabBar:
            return .small
        case .link:
            return .small
        }
    }
    
    public var height: CGFloat {
        return self.preferedSize.height
    }
    
    public var width: CGFloat? {
        switch self {
        case .primary(let size, _):
            switch size {
            case .small:
                return nil
            default:
                return 320
            }
        
        case .seccondary(let size, _):
            switch size {
            case .small:
                return nil
            default:
                return 320
            }
        
        case .textOnly(let size, _):
            switch size {
            case .small:
                return nil
            default:
                return 320
            }
            
        case .tabBar, .iconOnly:
            return 48
        case .link:
            return nil
        }
    }
    
    private var preferedSize: CGSize {
        switch self {
        case .primary(let size, _):
            if size == .small {
                return CGSize(width: 105, height: 32)
            }
            return CGSize(width: 320, height: 48)
            
        case .seccondary(let size, _):
            if size == .small {
                return CGSize(width: 105, height: 32)
            }
            return CGSize(width: 320, height: 48)
            
        case .textOnly(let size, _):
            if size == .small {
                return CGSize(width: 105, height: 32)
            }
            return CGSize(width: 320, height: 48)
            
        case .tabBar, .iconOnly:
            return CGSize(width: 48, height: 48)
        case .link:
            return .zero
        }
    }
    
    internal var isPlacedOnDarkBackground: Bool {
        switch self {
        case .primary(_, let isOnDarkBackground):
            return isOnDarkBackground
        case .seccondary(_, let isOnDarkBackground):
            return isOnDarkBackground
        case .textOnly(_, let isOnDarkBackground):
            return isOnDarkBackground
        case .iconOnly(let isOnDarkBackground):
            return isOnDarkBackground
        case .tabBar, .link:
            return false
        }
    }
    
    public static func == (lhs: UIFareButtonType, rhs: UIFareButtonType) -> Bool {
        let leftTypeDescription = String(describing: lhs)
        let rightTypeDescription = String(describing: rhs)
        
        return leftTypeDescription == rightTypeDescription &&
        lhs.size == rhs.size
    }
}

public protocol ThemeableButtonConfiguration {
    var backgroundColor: UIColor { get }
    var labelColor: UIColor { get }
    var iconTintColor: UIColor { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
}

public protocol ButtonTheme {
    var enabledConfiguration: ThemeableButtonConfiguration { get }
    var disabledConfiguration: ThemeableButtonConfiguration { get }
    var pressedConfiguration: ThemeableButtonConfiguration { get }
    var typographyStyle: TypographyStyle { get }
    var contentInsets: UIEdgeInsets { get }
    var cornerRadius: CGFloat { get }
    var showTitle: Bool { get }
    var showIcon: Bool { get }
    var iconSize: CGSize { get }
    var buttonPreferedSize: CGSize { get }
}
