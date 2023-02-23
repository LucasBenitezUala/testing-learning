//
//  ColombiaAPIManager.swift
//  UalaCore
//
//  Created by Milagros Alfonzo on 07/03/2022.
//

import Foundation

struct ColombiaAPIManager: APIManager {
    
    public init() { }
    public var card: CardRouteable = ColombiaCardRouter()
    public var regions: RegionsRouteable = RegionRouter()
    public var account: AccountRouteable = AccountRouter()
    public var virtualKey: VirtualKeyRouteable = DefaultVirtualKeyRouter()
    public var acquiringAccount: AcquiringAccountRoutable = AcquiringAccountRouter()
    var updateProfileMFA: UpdateProfileMFARoutable = UpdateProfileMFARouter()
}
