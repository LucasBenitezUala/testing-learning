//
//  ThemeTypographyProvider.swift
//  UalaFareUI
//
//  Created by Luis Perez on 15/07/22.
//

public enum ComponentType {
    case button(size: ComponentSize)
    case dynamicCell(type: UIFareCellType, component: DynamicCellComponent)
}

public enum DynamicCellComponent {
    case title
    case subtitle
    case button
    case bulletNumber
    case seccondarySubtitle
}

public protocol ThemeTypographyProvider: AnyObject {
    func typographyStyle(for component: ComponentType) -> TypographyStyle
}

final class DefaultThemeTypographyProvider: ThemeTypographyProvider {
    func typographyStyle(for component: ComponentType) -> TypographyStyle {
        switch component {
        case .button(let size):
            return buttonStyle(size: size)
            
        case .dynamicCell(let type, let component):
            return dynamicCellStyle(for: type, component: component)
        }
    }
    
    private func buttonStyle(size: ComponentSize) -> TypographyStyle {
        if size == .small {
            return .buttonMdRegular
        } else {
            return .buttonLgRegular
        }
    }
    
    private func dynamicCellStyle(for type: UIFareCellType, component: DynamicCellComponent) -> TypographyStyle {
        switch component {
        case .title:
            switch type {
            case .simpleNonActionable(_, _, _, _, _, let size, _, _):
                return size == .standart ? .labelMdBold : .labelLgBold
            case .simpleActionable(_, _, _, _, let size, _, _):
                return size == .standart ? .labelMdBold : .labelLgBold
            default:
                return .labelMdBold
            }
        case .subtitle:
            switch type {
            case .simpleNonActionable(_, _, _, _, _, _, let swapTitleWithSubtitle, _):
                return swapTitleWithSubtitle ? .labelSmRegular : .bodyMdRegular
            case .simpleActionable(_, _, _, _, _, let swapTitleWithSubtitle, _):
                return swapTitleWithSubtitle ? .labelSmRegular : .bodyMdRegular
            default:
                return .labelMdRegular
            }
        case .button:
            return .buttonMdRegular
        case .bulletNumber:
            return .bodySmRegular
        case .seccondarySubtitle:
            return .labelSmRegular
        }
    }
}
