//
//  ThemeManager.swift
//  UalaDSDemo
//
//  Created by Luis Perez on 29/06/22.
//

import UIKit

public protocol ThemeManager: Theme, AnyObject {
    func updateTheme(to theme: AvailableThemes)
}

public final class MainThemeManager: ThemeManager {
    private var currentTheme: Theme
    public static let themeUpdateNotificationName = Notification.Name(rawValue: "UalaThemeUpdated")
    public static let shared: ThemeManager = MainThemeManager()
    
    private init() {
        self.currentTheme = AvailableThemes.light.theme
    }
    
    public func color(for color: ThemedColors) -> UIColor {
        return currentTheme.color(for: color)
    }

    public func themedHex(for color: ThemedColors) -> String {
        return currentTheme.themedHex(for: color)
    }
    
    public func globalColor(for color: GlobalColors) -> UIColor {
        return currentTheme.globalColor(for: color)
    }
    
    public func spacing(for spacing: Spacings) -> CGFloat {
        return currentTheme.spacing(for: spacing)
    }
    
    public func addShadow(to view: UIView) {
        currentTheme.addShadow(to: view)
    }
    
    public func borderWidth(border: BorderWidth) -> BorderWidth {
        return currentTheme.borderWidth(border: border)
    }
    
    public func addCornerRadius(to view: UIView) {
        currentTheme.addCornerRadius(to: view)
    }
    
    public func updateTheme(to theme: AvailableThemes) {
        self.currentTheme = theme.theme
        notifyThemeUpdate()
    }
    
    public func toggleThemedModel() -> UIFareSwitchModel {
        currentTheme.toggleThemedModel()
    }
    
    public func tagThemedModel(status: UIFareTagStatus, size: ComponentSize) -> UIFareTagModel {
        currentTheme.tagThemedModel(status: status, size: size)
    }
    
    public func buttonTheme(for type: UIFareButtonType) -> ButtonTheme {
        currentTheme.buttonTheme(for: type)
    }
    
    public func textFieldTheme(placeholder: String?, rightIcon: Icon?, leftIcon: Icon?) -> TextFieldTheme {
        currentTheme.textFieldTheme(placeholder: placeholder, rightIcon: rightIcon, leftIcon: leftIcon)
    }
    
    public func amountFieldTheme(fieldType: AmountFieldType, currencySymbol: String, currencyLocaleIdentifier: String) -> AmountFieldTheme {
        currentTheme.amountFieldTheme(fieldType: fieldType, currencySymbol: currencySymbol, currencyLocaleIdentifier: currencyLocaleIdentifier)
    }
    
    public func codeFieldTheme(length: Int, keyboardType: UIKeyboardType, isSecureText: Bool) -> CodeFieldTheme {
        currentTheme.codeFieldTheme(length: length, keyboardType: keyboardType, isSecureText: isSecureText)
    }

    public func inputHelperTheme() -> InputHelperTheme {
        currentTheme.inputHelperTheme()
    }
    
    public func inputTextTheme(title: String?, helperText: String?, helperType: InputHelperType?, placeholder: String?, rightIcon: Icon?, leftIcon: Icon?) -> InputTextTheme {
        currentTheme.inputTextTheme(title: title, helperText: helperText, helperType: helperType, placeholder: placeholder, rightIcon: rightIcon, leftIcon: leftIcon)
    }
    
    public func inputAmountTheme(title: String?, fieldType: AmountFieldType, helperText: String?, helperType: InputHelperType?, currencySymbol: String, currencyLocaleIdentifier: String) -> InputAmountTheme {
        currentTheme.inputAmountTheme(title: title, fieldType: fieldType, helperText: helperText, helperType: helperType, currencySymbol: currencySymbol, currencyLocaleIdentifier: currencyLocaleIdentifier)
    }
    
    public func inputCodeField(length: Int, keyboardType: UIKeyboardType, isSecureText: Bool, helperText: String?, helperType: InputHelperType?) -> InputCodeTheme {
        currentTheme.inputCodeField(length: length, keyboardType: keyboardType, isSecureText: isSecureText, helperText: helperText, helperType: helperType)
    }
    
    public func radioButtonTheme() -> UIFareRadioButtonModel {
        currentTheme.radioButtonTheme()
    }
    
    public func checkboxTheme() -> UIFareCheckboxModel {
        currentTheme.checkboxTheme()
    }
    
    public func themedDynamicInformationCellModel(for type: UIFareCellType) -> UIFareCellModel {
        currentTheme.themedDynamicInformationCellModel(for: type)
    }
    
    public func cardTheme(cardType: UIFareCardType) -> UIFareCardModel {
        currentTheme.cardTheme(cardType: cardType)
    }
    
    public func tabBarControllerTheme() -> UIFareTabBarControllerTheme {
        return currentTheme.tabBarControllerTheme()
    }
    
    public func navigationBarAppearance(barType: NavigationBarType) -> NavigationBarAppearance {
        return currentTheme.navigationBarAppearance(barType: barType)
    }
    
    private func notifyThemeUpdate() {
        NotificationCenter.default.post(name: Self.themeUpdateNotificationName,
                                        object: nil,
                                        userInfo: nil)
    }
}
