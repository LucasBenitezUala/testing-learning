//
//  DefaultCardRouter.swift
//  UalaCore
//
//  Created by Uala on 18/08/21.
//

import Alamofire

struct DefaultCardRouter: CardRouteable {
    
    var route: CardRoute = .cards
    
    /*
     This may be confusing, but the .enable case is to activate the card
     and the .activate case is to unfreeze the card.
     */
    var path: String {
        switch route {
        case .cards:
            return "/1/users/products"
        case.block:
            return "/1/cards/freeze"
        case .activate:
            return "/1/cards/unfreeze"
        case .enable:
            return "/1/cards/activate"
        case .createPin, .updatePin, .getCardPinURL:
            return "/1/cards/update-pin"
        case .getNipImage(cardId: let cardId):
            return "/1/cards/\(cardId)/pin"
        }
    }
    
    var mapper: Mappeable {
        switch route {
        case .cards:
            return DefaultCardsMapper()
        case .enable:
            return MxEnableCardMapper()
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
    
    var parameters: Parameters? {
        switch route {
        case .cards, .createPin, .updatePin, .getCardPinURL, .getNipImage(cardId: _):
            return nil
        case .block(let lastDigits),
             .activate(let lastDigits):
            return ["lastFourDigits": lastDigits]
        case .enable(let lastDigits, let expiryDate):
            return ["lastFourDigits": lastDigits, "expiryDate": expiryDate]
        }
    }
    
    var headers: HTTPHeaders? {
        switch route {
        case .createPin(let txPin):
            guard let txPin = txPin else { return nil }
            return ["pin": txPin]
        default:
            return nil
        }
    }
}
