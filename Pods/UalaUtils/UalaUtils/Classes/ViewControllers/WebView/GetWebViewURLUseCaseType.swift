//
//  GetWebViewURLUseCase.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 12/10/21.
//

import Foundation
import PromiseKit

@available(*, deprecated, message: "Use GetWebViewURLUseCaseKind protocol instead")
public protocol GetWebViewURLUseCaseType {
    
    func execute() -> Promise<URL?>
}

public protocol GetWebViewURLUseCaseKind {
    
    func execute() async throws -> URL?
}
