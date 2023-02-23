//
//  UserManagementRouter.swift
//  UalaCore
//
//  Created by Ualá on 04/08/21.
//

import Alamofire

struct UserManagementRouter: UserManagementRoutable {
    
    var route: UserManagementRoute = .addBeneficiary("", "", "", "", 0, "", "")
    
    var path: String {
        switch route {
        case .addBeneficiary:
            return "/1/beneficiaries"
        case .getBeneficiariesList:
            return "/1/beneficiaries"
        case .deleteBeneficiary(let id, _, _):
            return "/1/beneficiaries/\(id)"
        }
    }
    
    public var method: HTTPMethod {
        switch route {
        case .addBeneficiary:
            return .post
        case .getBeneficiariesList:
            return .get
        case .deleteBeneficiary:
            return .delete
        }
    }
    
    var mapper: Mappeable {
        switch route {
        case .addBeneficiary, .deleteBeneficiary:
            return AddBeneficiaryMapper()
        case .getBeneficiariesList:
            return BeneficiaryItemsMapper()
        }
    }
    
    var baseUrl: String {
        return String.getConfigurationValue(forKey: .userManagementURL, from: .Core)
    }
    
    var encoding: ParameterEncoding {
        switch route {
        case .addBeneficiary, .getBeneficiariesList, .deleteBeneficiary:
            return JSONEncoding.default
        }
    }
    
    var parameters: Parameters? {
        switch route {
        case .addBeneficiary(let beneficiaryBirth,
                             let beneficiaryEmail,
                             let beneficiaryLastName,
                             let beneficiaryName,
                             let percentage,
                             let mfaPin,
                             let mfaPinId):
            return [
                "beneficiaryBirth": beneficiaryBirth,
                "beneficiaryEmail": beneficiaryEmail,
                "beneficiaryLastName": beneficiaryLastName,
                "beneficiaryName": beneficiaryName,
                "percentage": percentage,
                "mfaPin": mfaPin,
                "mfaPinId": mfaPinId
            ]
        case .deleteBeneficiary(_,
                                let mfaPin,
                                let mfaPinId):
            return [
                "mfaPin": mfaPin,
                "mfaPinId": mfaPinId
            ]
        default:
            return nil
        }
    }
}
