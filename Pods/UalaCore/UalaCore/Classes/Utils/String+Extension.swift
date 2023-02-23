//
//  String+Extension.swift
//  UalaCore
//
//  Created by Agustin Jaimes on 04/05/22.
//

import Foundation

extension String {
    func formatPhoneNumber() -> String? {
        let codePrefix: String = String.getConfigurationConstant(forKey: .internationalDialCode)
        let internationalPrefix: String = String.getConfigurationConstant(forKey: .internationalDialPrefix)
        let internationalCodePrefix: String = internationalPrefix + codePrefix

        if self.hasPrefix(internationalCodePrefix) {
            let phone: String = dropFirst(internationalCodePrefix.count).trimmingCharacters(in: .whitespacesAndNewlines)
            return internationalPrefix + phone
        } else if self.hasPrefix(internationalPrefix) {
            return self
        } else if !self.hasPrefix(internationalCodePrefix) && !self.hasPrefix(internationalPrefix) {
            return internationalPrefix + self
        } else {
            return nil
        }
    }
}
