import Alamofire

public enum CardRoute {
    case cards, activate(String), block(String), enable(String, String?),
         createPin(String?), updatePin, getCardPinURL, getNipImage(cardId: String)
}

public protocol CardRouteable: Routeable {
    var route: CardRoute { get set }
}

extension CardRouteable {
    
    var baseUrl: String {
        let environment: Environment = ServiceLocator.inject()
        switch (environment, route) {
            case (is MexicoABC, _): return String.getConfigurationValue(forKey: .baseUrlCard, from: .Core)
            case (is Argentina, .cards): return String.getConfigurationValue(forKey: .baseUrlCardBFF, from: .Core)
            default: return String.getConfigurationValue(forKey: .baseUrlDebit, from: .Core)
        }
    }
    
    var method: HTTPMethod {
        switch route {
        case .cards, .createPin, .getCardPinURL, .getNipImage(cardId: _):
            return .get
        case .activate, .block:
            return .put
        case .enable, .updatePin:
            return .post
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var parameters: Parameters? {
        switch route {
        case .cards, .createPin, .updatePin, .getCardPinURL, .getNipImage(cardId: _):
            return nil
        case .block(let lastDigits),
             .activate(let lastDigits):
            return ["lastFourDigits": lastDigits]
        case .enable(let lastDigits, _):
            return ["lastFourDigits": lastDigits]
        }
    }
    
    var path: String {
        switch route {
        case .cards:
            return "/1/cards"
        case.block:
            return "/1/cards/block"
        case .activate:
            return "/1/cards/activate"
        case .enable:
            return "/1/cards/enable"
        case .createPin, .updatePin, .getCardPinURL:
            return "/1/cards/update-pin"
        case .getNipImage(cardId: let cardId):
            return "/1/cards\(cardId)/pin"
        }
    }
    
    var mapper: Mappeable {
        switch route {
        case .cards, .enable:
            return CardsMapper()
        case .block, .activate:
            return CardMapper()
        case .createPin, .getCardPinURL:
            return CreateATMPinMapper()
        case .updatePin:
            return EmptyMapper()
        case .getNipImage(cardId: _):
            return NipMapper()
        }
    }
}

struct CardRouter: CardRouteable {
    var route: CardRoute = .cards
}
