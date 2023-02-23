import Foundation

public struct AuthConfig {
    public var database = String.getConfigurationValue(forKey: .authConfigDatabase, from: .Core)
    public var domain = String.getConfigurationValue(forKey: .authConfigDomain, from: .Core)
    public var audience = String.getConfigurationValue(forKey: .authConfigAudience, from: .Core)
    public var clientId = String.getConfigurationValue(forKey: .authConfigClientId, from: .Core)
    public var baseUrlDeviceId = String.getConfigurationValue(forKey: .baseUrlDeviceId, from: .Core)
    public var defaultScope = String.getConfigurationValue(forKey: .authConfigDefaultScope, from: .Core)
    public var enrollScope = String.getConfigurationValue(forKey: .authConfigEnrollScope, from: .Core)
    public var enrollAudience = String.getConfigurationValue(forKey: .authConfigEnrollAudience, from: .Core)

    public init() {}
}

extension Environment {
    var authConfig: AuthConfig {
        AuthConfig()
    }
}
