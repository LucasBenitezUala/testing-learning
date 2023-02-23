//
//  MexicoABCAPIManager.swift
//  UalaCore
//
//  Created by Luis Perez on 19/10/21.
//

struct MexicoABCAPIManager: APIManager {
  
    public init() { }
    public var card: CardRouteable = MexCardRouter()
    public var regions: RegionsRouteable = RegionRouter()
    public var account: AccountRouteable = MexicoACBAccountRouter()
    public var virtualKey: VirtualKeyRouteable = VirtualKeyRouter()
    public var acquiringAccount: AcquiringAccountRoutable = AcquiringAccountRouter()
    var updateProfileMFA: UpdateProfileMFARoutable = UpdateProfileMFARouter()
}
