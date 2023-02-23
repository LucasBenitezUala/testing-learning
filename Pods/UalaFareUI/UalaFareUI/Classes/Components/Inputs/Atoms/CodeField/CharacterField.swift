//
//  CharacterField.swift
//  UalaFareUI
//
//  Created by Matías Schwalb on 16/08/2022.
//

protocol CharacterFieldDeleteBackwardDelegate {
    func deleteBackwardInEmptyField(textField: UITextField)
}

class CharacterField: UITextField {
    var deleteBackwardDelegate: CharacterFieldDeleteBackwardDelegate?

    override public func deleteBackward() {
        super.deleteBackward()
        if let text = text, text.isEmpty {
            guard let deleteBackwardDelegate = deleteBackwardDelegate else {
                return
            }

            deleteBackwardDelegate.deleteBackwardInEmptyField(textField: self)
        }
    }
}
