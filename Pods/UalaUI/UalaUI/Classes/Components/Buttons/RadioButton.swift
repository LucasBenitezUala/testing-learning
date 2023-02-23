//
//  SelectableButton.swift
//  UalaUI
//
//  Created by Francisco Javier Saldivar Rubio on 27/06/22.
//

import UIKit

final public class RadioButton: UIButton {
    private var target: Any?
    private var selector: Selector?
    private var controlEvents: UIControl.Event?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp() {
        setImage(BundleImage(bundle: .Common, named: "radiobutton_inactive"), for: .normal)
        setImage(BundleImage(bundle: .Common, named: "radiobutton_active"), for: .selected)
        adjustsImageWhenHighlighted = false
        backgroundColor = .clear
        tintColor = .clear
        super.addTarget(self, action: #selector(onSelected), for: .touchUpInside)
    }
    
    public override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        self.target = target
        self.selector = action
    }
    
    @objc private func onSelected() {
        isSelected = !isSelected
        guard let selector = selector,
        let target = target as? AnyObject else {
            return
        }
        target.perform(selector, with: self)
    }
}
