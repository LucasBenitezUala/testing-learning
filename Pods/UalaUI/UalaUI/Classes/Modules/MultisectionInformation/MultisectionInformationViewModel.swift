//
//  MultisectionInformationViewModel.swift
//  UalaUI
//
//  Created by Matías Schwalb on 27/04/2022.
//

import Foundation

public struct MultisectionInformationViewModel {
    public let title: String?
    public let navigationTitle: String?
    public let sections: [MultisectionInformationViewSection]
    public let mainButton: MultisectionInformationViewButton?
    public let secondaryButton: MultisectionInformationViewButton?
    public let feeInformation: String
    
    public init(title: String? = nil,
                navigationTitle: String? = nil,
                sections: [MultisectionInformationViewSection],
                mainButton: MultisectionInformationViewButton?,
                secondaryButton: MultisectionInformationViewButton?,
                feeInformation: String? = nil) {
        self.title = title ?? ""
        self.navigationTitle = navigationTitle ?? ""
        self.sections = sections
        self.mainButton = mainButton
        self.secondaryButton = secondaryButton
        self.feeInformation = feeInformation ?? ""
    }
}

public struct MultisectionInformationViewSection {
    public let sectionTitle: String?
    public let optionalButtonIcon: UIImage?
    public let buttonClosure: (() -> Void)
    public let rows: [MultisectionInformationViewRow]
    
    public init(sectionTitle: String? = nil, optionalButtonIcon: UIImage? = nil, buttonClosure: (() -> Void)? = nil, rows: [MultisectionInformationViewRow] ) {
        self.sectionTitle = sectionTitle
        self.optionalButtonIcon = optionalButtonIcon ?? nil
        self.buttonClosure = buttonClosure ?? {
//            empty closure if buttonClosure is nil
        }
        self.rows = rows
    }
}

public struct MultisectionInformationViewRow {
    public let rowTitle: String
    public let icon: String
    public let cellClass: MultisectionInformationCellProtocol
    public let buttonText: String
    public let height: CGFloat
    
    public init(rowTitle: String? = nil, icon: String? = nil, cellClass: MultisectionInformationCellProtocol, buttonText: String? = nil, height: CGFloat) {
        self.rowTitle = rowTitle ?? ""
        self.icon = icon ?? ""
        self.cellClass = cellClass
        self.buttonText = buttonText ?? ""
        self.height = height
    }
}

public struct MultisectionInformationViewButton {
    public let buttonTitle: String
    public let style: ButtonStyle?
    
    public init(buttonTitle: String, style: ButtonStyle? = nil) {
        self.buttonTitle = buttonTitle
        self.style = style
    }
}
