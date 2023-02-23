import Alamofire

enum MFARoute {
    case challenge(token: String)
    case login(token: String, oob: String, code: String)
    case associate(phone: String, method: String, mfaToken: String = "")
    case register(UUID: String)
}

protocol MFARouteable: Routeable {
    var route: MFARoute { get set }
}

struct MFARouter {
    private let oob = "oob"
    private let client: String
    private let domain: String
    var route: MFARoute = .challenge(token: "")
    private let grantType: String = String.getConfigurationValue(forKey: .mfaGrantType, from: .Core)
    private let baseUrlDeviceId: String?

    init(_ client: String, _ domain: String, _ baseUrlDeviceId: String? = nil) {
      self.client = client
      self.domain = domain
      self.baseUrlDeviceId = baseUrlDeviceId
    }
}

extension MFARouter: MFARouteable {

    var path: String {
        switch route {
        case .challenge:
            return "/mfa/challenge"
        case .associate:
            return "mfa/associate"
        case .login:
            return "/oauth/token"
        case .register:
            return "/api/v1/devices"
        }
    }

    public var method: HTTPMethod {
      switch route {
        case .register:
          return .put
        default:
          return .post
        }
    }

    public var encoding: ParameterEncoding {
      switch route {
      case .challenge, .associate:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }

    public var parameters: Parameters? {
      switch route {
        case .challenge(let token):
            return [
                "client_id": client,
                "challenge_type": oob,
                "mfa_token": token
            ]

        case .associate(let phone, let method, _):
            return [
                "authenticator_types": [oob],
                "oob_channels": [method],
                "phone_number": phone
            ]

        case .login(let token, let oob, let code):
            return [
                "client_id": client,
                "oob_code": oob,
                "mfa_token": token,
                "binding_code": code,
                "grant_type": grantType
            ]
            
        case .register(let UUID):
            return [
                "deviceId": UUID
            ]
        }
    }

    var mapper: Mappeable {
      switch route {
        case .challenge, .associate:
            return OOBMapper()
      case .register:
          return RegisterMapper()
        default:
            return CrendentialMapper()
        }
    }

    var errorMapper: Mappeable {
        MFAClientErrorMapper()
    }

    var baseUrl: String {
      switch route {
        case .register:
          return baseUrlDeviceId ?? ""
        default:
          return "https://\(domain)"
      }
    }
    
    var headers: HTTPHeaders? {
      switch route {
        case .register:
            return ["Content-Type": "application/json"]
      case .associate(_, _, let mfaToken):
          return mfaToken.isEmpty ? nil : ["Authorization": "Bearer \(mfaToken)"]
        default:
            return nil
        }
    }
}
