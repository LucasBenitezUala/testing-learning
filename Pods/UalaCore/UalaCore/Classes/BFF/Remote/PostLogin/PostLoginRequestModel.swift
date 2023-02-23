//
//  PostLoginRequestModel.swift
//  Uala
//
//  Created by Andrés Abraham Bonilla Gómex on 28/04/22.
//  Copyright © 2022 Ualá. All rights reserved.
//

struct PostLoginRequestModel {
    
    let advertisingPlatform: String
    let pushToken: String
    let pushPlatform: String
    let deviceId: String
    
    init(advertisingPlatform: String = "iOS",
         pushToken: String = "",
         pushPlatform: String = ApplicationConfiguration.current() == .production ? "APNS" : "APNS_SANDBOX",
         deviceId: String = (UIDevice.current.identifierForVendor?.uuidString ?? "")) {
        self.advertisingPlatform = advertisingPlatform
        self.pushToken = pushToken
        self.pushPlatform = pushPlatform
        self.deviceId = deviceId
    }
}
