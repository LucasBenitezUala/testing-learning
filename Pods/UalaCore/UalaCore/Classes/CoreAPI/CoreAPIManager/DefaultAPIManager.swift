//
//  DefaultAPIManager.swift
//  UalaCore
//
//  Created by Federico Frias on 10/05/2021.
//

import Foundation

struct DefaultAPIManager: APIManager {
  
    public init() { }
    public var card: CardRouteable = DefaultCardRouter()
    public var regions: RegionsRouteable = RegionRouter()
    public var account: AccountRouteable = AccountRouter()
    public var virtualKey: VirtualKeyRouteable = DefaultVirtualKeyRouter()
    public var acquiringAccount: AcquiringAccountRoutable = AcquiringAccountRouter()
    var updateProfileMFA: UpdateProfileMFARoutable = UpdateProfileMFARouter()
}
