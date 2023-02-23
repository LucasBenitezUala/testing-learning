import Foundation

struct ArgentinaAPIManager: APIManager {
            
    public init() { }
    public var card: CardRouteable = CardRouter()
    public var regions: RegionsRouteable = RegionRouter()
    public var account: AccountRouteable = ArgentinaAccountRouter()
    public var virtualKey: VirtualKeyRouteable = ArgVirtualKeyRouter()
    public var acquiringAccount: AcquiringAccountRoutable = AcquiringAccountRouter()
    var updateProfileMFA: UpdateProfileMFARoutable = UpdateProfileMFARouter()
}
