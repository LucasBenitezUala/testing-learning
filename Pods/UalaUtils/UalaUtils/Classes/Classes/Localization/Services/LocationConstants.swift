//
//  LocationConstants.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 21/10/21.
//

import Foundation

public enum LocationError: Error {
    case unavailableLocation
    case checkCLAAuthorization
    case unknown
}

public enum RequestTypeLocation {
    case always
    case whenInUse
}
