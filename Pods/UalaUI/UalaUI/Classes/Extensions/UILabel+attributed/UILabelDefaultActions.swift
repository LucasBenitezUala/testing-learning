//
//  UILabelDefaultActions.swift
//  UalaUI
//
//  Created by Francisco Javier Saldivar Rubio on 06/05/22.
//

import Foundation
import PromiseKit
import UalaUtils

public enum UalaLabelSelector {}

extension UalaLabelSelector {
    public struct NumberPhone: UalaLabelSelectorDelegate {
        public var number: String
        private var urlPhone: String = "tel://"
        public init(number: String) {
            self.number = number
        }

        public func onSelected(value: UalaAttributedString) {
            guard let value = URL(string: "\(urlPhone)\(number)") else {
                LogManager.shared.debug(info: "Error, this attributed not is URL")
                return
            }
            UIApplication.shared.open(value, options: [:], completionHandler: nil)
        }
    }

    public struct Link: UalaLabelSelectorDelegate {
        public var url: URL

        public init(url: URL) {
            self.url = url
        }

        public func onSelected(value: UalaAttributedString) {
            UIApplication.shared.open(url)
        }
    }
}
