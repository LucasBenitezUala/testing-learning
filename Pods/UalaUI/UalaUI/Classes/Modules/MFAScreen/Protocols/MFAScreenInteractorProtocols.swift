//
//  MFAScreenInteractorProtocols.swift
//  UalaUI
//
//  Created by Rodrigo Torres on 26/05/2022.
//

import UIKit

public protocol MFAScreenInteractorType: AnyObject {
    var presenter: MFAScreenPresenterType? { get set }

    func validateCode(code: String) async throws
}

public extension MFAScreenInteractorType {

    func validateCode(code: String) async throws {
        // Empty default implementation
    }
}
