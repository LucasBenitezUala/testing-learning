//
//  Date+Extensions.swift
//  UalaUtils
//
//  Created by Ualá on 08/04/22.
//

import Foundation

public extension Date {
    
    private var calendar: Calendar { return Calendar.current }
    
    func currentDateContains( component: Calendar.Component ) -> Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: component)
    }
}
