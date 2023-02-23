import Auth0

class MFAClientErrorMapper: MappeableType {
    typealias Result = MFAClientErrorResponse
    
    func map<T>(_ data: Data) -> T? {
        guard let decodedData = decode(data) else {
            return UalaError.undefined as? T
        }
        
        return mapAuth0ErrorCode(decodedData) as? T
    }
    
    private func mapAuth0ErrorCode(_ authError: MFAClientErrorResponse) -> UalaError {
        switch authError.error {
        case MFAClientError.associationRequired.rawValue:
            return UalaError.MFAAssociationRequired
        case MFAClientError.invalidGrant.rawValue:
            return mapInvalidGrantWith(description: authError.errorDescription)
        case MFAClientError.invalidRequest.rawValue:
            return mapInvalidRequestWith(description: authError.errorDescription)
        default:
            return UalaError.undefined
        }
    }
    
    private func mapInvalidGrantWith(description: String) -> UalaError {
        switch description {
        case MFAClientError.ErrorDescription.invalidBindingCode.rawValue, MFAClientError.ErrorDescription.invalidOTPCode.rawValue:
            return UalaError.MFAInvalidCode
        default:
            return UalaError.undefined
        }
    }
    
    private func mapInvalidRequestWith(description: String) -> UalaError {
        switch description {
        case MFAClientError.ErrorDescription.tooManySMSSent.rawValue:
            return UalaError.TooManyMFACodesSent
        case MFAClientError.ErrorDescription.tooManyFailedCodes.rawValue:
            return UalaError.TooManyMFAInvalidCodes
        default:
            return UalaError.undefined
        }
    }
}

struct MFAClientErrorResponse: Decodable {
    let error: String
    let errorDescription: String
    
    enum CodingKeys: String, CodingKey {
        case error
        case errorDescription = "error_description"
    }
}

private enum MFAClientError: String {
    case associationRequired = "association_required"
    case invalidGrant = "invalid_grant"
    case invalidRequest = "invalid_request"
    
    enum ErrorDescription: String {
        case invalidBindingCode = "Invalid binding_code."
        case invalidOTPCode = "Invalid otp_code."
        case tooManySMSSent = "Too many SMS sent by the user. Wait for some minutes before retrying."
        case tooManyFailedCodes = "Too many failed codes. Wait for some minutes before retrying."
    }
}
