import Foundation

public enum AccountStatus: String {
    
    case unknown
    case created = "CREATED"
    case pendingValidation = "PENDING_VALIDATION"
    case pendingAutomaticValidation = "PENDING_AUTOMATIC_VALIDATION"
    case pendingUserAction = "PENDING_USER_ACTION"
    case pendingComplianceValidation = "PENDING_COMPLIANCE_VALIDATION"
    case valid = "VALID"
    case invalid = "INVALID"
    case externalCreationError = "EXTERNAL_CREATION_ERROR"
    case error = "ERROR"
    case closed = "CLOSED"
    case blacklisted = "BLACKLISTED"
    case failValidationCurp = "FAIL_VALIDATION_CURP"
    case failKYC = "FAIL_KYC"
    case pendingDeviceLink = "PENDING_DEVICE_LINK"
    case failClientRegister = "FAIL_CLIENT_REGISTER"
    case notCreated = "ACCOUNT_NOT_CREATED"
    case failCreation = "FAIL_CREATION"
    case failAccountCreation = "FAIL_ACCOUNT_CREATION"
    case failAccountKYC = "FAIL_ACCOUNT_KYC"
    case rejected = "REJECTED"
}

public class Account {
    
    public struct UserPendingAction {
        public let type: String
        let description: String
    }
    
    public let id: String
    public let username: String?
    public let firstname: String?
    public let lastname: String?
    public let status: AccountStatus
    public var picture: String?
    public var hasPin: Bool = true
    public var userPendingAction: UserPendingAction?
    public let email: String?
    public let phone: String?
    public var fullname: String? {
        guard let firstname = firstname,
              let lastname = lastname else { return nil }
        return "\(firstname.capitalized) \(lastname.capitalized)"
    }
    
    @available(*, deprecated, message: "Use userType property instead")
    public var isPPJJ: Bool = false
    public let displayName: String
    public let userType: UserType
    public let action: PostLoginAction
    
    public init(metadata: String?,
                id: String,
                username: String?,
                firstname: String?,
                lastname: String?,
                status: String,
                picture: String?,
                hasPin: Bool,
                email: String?,
                phone: String?,
                displayName: String = "",
                userType: UserType = .unknown,
                action: PostLoginAction = PostLoginAction()) {
        self.id = id
        self.username = username
        self.firstname = firstname
        self.lastname = lastname
        self.status = AccountStatus(rawValue: status) ?? .unknown
        self.picture = picture
        self.email = email
        self.phone = phone
        self.hasPin = hasPin
        self.displayName = displayName
        self.userType = userType
        self.action = action
        
        if let metadata = metadata {
            self.userPendingAction = BancarMetadata(with: metadata).pendingAction()
        }
    }
}

extension BancarMetadata {
    func pendingAction() -> Account.UserPendingAction {
        return Account.UserPendingAction(type: self.dict["userActionType"] ?? "", description: self.dict["userActionDescription"] ?? "")
    }
}
