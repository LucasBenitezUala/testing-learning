import UIKit
import Foundation

public class DeepLinking {
    public static func triggerDeepLink(dlIntent: DeepLinkIntent) {
        if let appurl = dlIntent.getURL(),
           UIApplication.shared.canOpenURL(appurl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appurl)
            } else {
                UIApplication.shared.openURL(appurl)
            }
        }
    }
}

public enum DeepLinkIntent {
    case goToReferrals
    case goHome
    case goToChat
    case goToChatBot
    case goToRecharge
    case goToRecoverPassword
    case goToInviteUala
    case goToHelp
    case goToCard
    case goToContact
    case goToFAQ(_ id: String)
    case goToTransactionDetail(_ id: String)
    case goToNPS(_ id: String)
    case goToAccountInstructions

    private func makeURL(scheme: DeepLinkURLs? = .schemeURL ,
                         host: DeepLinkURLs? = .hostURL,
                         path: DeepLinkURLs) -> URL? {
        var components = URLComponents()
        components.scheme = scheme?.rawValue
        components.host = host?.rawValue
        components.path = path.rawValue
        return components.url
    }

    public func getURL() -> URL? {
        switch self {
        case .goHome:
            return makeURL(path: .HOME)
        case .goToChat:
            return makeURL(path: .chat)
        case .goToChatBot:
            return makeURL(path: .chatbot)
        case .goToContact:
            return makeURL(path: .contacto)
        case .goToRecharge:
            return makeURL(path: .RECHARGE)
        case .goToRecoverPassword:
            return makeURL(path: .RECOVER_PASSWORD)
        case .goToInviteUala:
            return makeURL(path: .INVITE_UALA)
        case .goToHelp:
            return makeURL(path: .help)
        case .goToCard:
            return makeURL(path: .cuenta)
        case .goToFAQ(let id):
            let baseURL = makeURL(path: .help)
            return URL(string: baseURL?.appendingPathComponent("?id=\(id)").absoluteString.removingPercentEncoding ?? "")
        case .goToTransactionDetail(let id):
            let baseURL = makeURL(path: .transactionDetail)
            return URL(string: baseURL?.appendingPathComponent("?id=\(id)").absoluteString.removingPercentEncoding ?? "")
        case .goToNPS(let id):
            let baseURL = makeURL(path: .NPS)
            return URL(string: baseURL?.appendingPathComponent("?id=\(id)").absoluteString.removingPercentEncoding ?? "")
        case .goToReferrals:
            return makeURL(path: .MGM_INVITE)
        case .goToAccountInstructions:
            return makeURL(path: .accountInstructions)
        }
    }
}

// swiftlint:disable identifier_name
public enum DeepLinkURLs: String {
    case schemeURL = "uala"
    case hostURL = "deeplink"
    case RECHARGE = "/recharge"
    case RECOVER_PASSWORD = "/recoverPassword"
    case INVITE_UALA = "/inviteUala"
    case MGM_INVITE = "/referidos"
    case HOME = "/home"
    case EXT_TRANSFER = "/transferencias"
    case EXT_PAYMENTS_HOME = "/pagos-y-servicios"
    case EXT_RECHARGE = "/recargas"
    case EXT_BILLS = "/facturas"
    case EXT_PFM = "/analisis"
    case EXT_INVESTMENT = "/inversiones"
    case EXT_INVESTMENT_AUTOM_SUSCRIPT = "/inversiones-automaticas"
    case EXT_INVESTMENT_FULL = "/inversiones/full"
    case EXT_INSTALLMENTS = "/cuotificacion"
    case EXT_INSTALLMENTS_CONSUMPTIONS = "/cuotificacion-consumos"
    case EXT_LOANS = "/prestamos"
    case EXT_FINANCIAL = "/analisisfinanciero"
    case EXT_FOUND_CARD = "/tracking-card"
    case EXT_LOYALTY = "/loyalty"
    case EXT_PROFILE = "/perfil"
    case EXT_PORTFOLIO = "/portfolio"
    case EXT_PUSH_TRANSFER_DETAIL_CLAIM = "/reclamo-transferencia-detalle"
    case EXT_SAMSUNG = "/prestamos/samsung"
    case EXCHANGE = "/mep"
    case CEDEARS = "/cedears"
    case NPS = "/nps"
    
    // MARK: Acquiring
    case ACQUIRING = "/cobros"
    case ACQUIRING_BUY_MPOS = "/cobros-compra-mpos"

    // MARK: CX
    case cambiarClave = "/push-change-code"
    case cambiarContrasena = "/push-change-pwd"
    case cambiarPIN = "/change-pin"
    case cambiarTelefono = "/cambiar-telefono"
    case chat = "/chat"
    case chatbot = "/chatbot"
    case comoDepositar = "/cashin"
    case contacto = "/contact"
    case cuenta = "/cuenta"
    case help = "/help"
    case recuperarClave = "/push-recover-code"
    case datosRegulatorios = "/datos-regulatorios"
    case withdrawal = "/cashout"

    // MARK: Insurance
    case insurance = "/insurance"

    // MARK: Promotions
    case promociones = "/promociones"

    // MARK: Taxes calculator
    case calculadoraImpuestos = "/taxes-calculator"

    // MARK: Apple Pay
    case inAppVerification = "/Inappverification"

    // MARK: Transactions
    case transactionDetail = "/transactionDetail"
    
    // MARK: QR
    case qrPayment = "/pago-qr"
    
    // MARK: Remittance
    case remittances = "/remittances"
    
    // MARK: VirtualKey
    case accountInstructions = "/VirtualKey"

    public func getIndex() -> Int {
        switch self {
        case .EXT_TRANSFER:
            return 1
        case .cuenta:
            return 2
        case .EXT_PAYMENTS_HOME:
            return 3
        case .EXT_PFM:
            return 4
        default:
            return 0
        }
    }
}
