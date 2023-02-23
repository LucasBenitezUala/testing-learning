//
//  GradientFieldView.swift
//  UalaUI
//
//  Created by Diego Palomares on 17/02/22.
//

import UIKit

public class GradientFieldView: BaseFieldView {
    
    @IBOutlet weak var gradientBar: LoaderGradientBar!
    
    public func startShimmering(isLoading: Bool) {
        gradientBar.isLoading(isLoading)
    }
}
