//
//  ViewModelPicker.swift
//  UalaAuth
//
//  Created by Andrés Abraham Bonilla Gómex on 17/05/22.
//

import UalaCore

internal class SchemesPicker: BasePicker<Scheme> {
    
    init(schemes: [Scheme] = [.develop, .production, .stage, .test]) {
        super.init(options: schemes)
    }
}

internal class CountryPicker: BasePicker<CountryEnvironment> {
    
    init(countries: [CountryEnvironment] = CountryEnvironment.allCases) {
        super.init(options: countries)
    }
}
