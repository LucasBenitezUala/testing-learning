//
//
//  BasePicker.swift
//  UalaAuth
//
//  Created by Andrés Abraham Bonilla Gómex on 19/10/21.
//  Copyright © 2021 Ualá. All rights reserved.
//
//

import Foundation
import UalaCore

internal protocol PickerDelegate: AnyObject {
    func selectedOption()
}

internal class BasePicker<T: RawRepresentable>: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private let buttonWidth: CGFloat = 0
    private let buttonHeight: CGFloat = 50
    private let redColor: CGFloat = 102.0/255
    private let greenColor: CGFloat = 138.0/255.0
    private let blueColor: CGFloat = 253.0/255

    let options: [T]
    var currentOption: T?
    
    let button: UIButton
    let picker: UIPickerView
    weak var delegate: PickerDelegate?
    
    init(options: [T]) {
        self.options = options
        self.currentOption = options.first
        self.picker = UIPickerView()
        self.button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: buttonWidth,
                                                                         height: buttonHeight)))
        super.init()
        
        setup()
    }
    
    func setup() {
        button.backgroundColor = UIColor(red: redColor,
                                         green: greenColor,
                                         blue: blueColor,
                                         alpha: 1)

        button.setTitle("Seleccionar", for: .normal)
        button.addTarget(self, action: #selector(didClickOn), for: .touchUpInside)
        button.accessibilityIdentifier = LoginDemoIdentifiers.loginDemoSelectButton
        picker.delegate = self
        picker.dataSource = self
        picker.accessibilityIdentifier = LoginDemoIdentifiers.loginDemoPicker
    }
    
    @objc private func didClickOn() {
        delegate?.selectedOption()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row].rawValue as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentOption = options[row]
    }
}
