import Foundation
import AWSCore

public struct DefaultAmazonConfiguration: AmazonConfiguration {
            
    public var region = AWSRegionType.USEast1
    public var userPoolKey = "UserPool"
    public var s3TransferUtilityKey = "USEast1S3TransferUtility"
    public var accessKey = "AKIAJEEZFVACODGOXLUA"
    public var secretKey = "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"
    public var scheme: Scheme = .stage
    
    public init() {
        // This is empty because we need to expose de initializer.
    }
    
    public var endPoint: String {
        return String.getConfigurationValue(forKey: .baseUrlDebit, from: .Core)
    }

    public var userPoolId: String {
        return String.getConfigurationValue(forKey: .amazonUserpoolId, from: .Core)
    }

    public var clientId: String {
        return String.getConfigurationValue(forKey: .amazonClientId, from: .Core)
    }

    public var identityPoolId: String {
        return String.getConfigurationValue(forKey: .amazonIdentityPoolId, from: .Core)
    }

    public var s3BucketName: String {
        return String.getConfigurationValue(forKey: .amazonS3BucketName, from: .Core)
    }
}
