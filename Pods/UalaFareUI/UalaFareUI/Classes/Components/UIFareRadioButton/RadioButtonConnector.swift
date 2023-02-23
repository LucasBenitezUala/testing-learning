//
//  RadioButtonConnector.swift
//  UalaFareUI
//
//  Created by Luis Perez on 01/09/22.
//

// This helper class allows us to connect the radio buttons with another, so they can stay in sync
final public class RadioButtonConnector {
    static public func connectButtons(_ buttons: [UIFareRadioButton]) {
        let pendingButtons: [UIFareRadioButton] = buttons
        for button in buttons {
            pendingButtons.forEach { pendingButton in
                if pendingButton != button {
                    pendingButton.addRadioButtonReference(button: button)
                }
            }
        }
    }
}
