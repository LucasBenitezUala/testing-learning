import Foundation
import PromiseKit

public protocol CardRepositoryProtocol {
    func cards() -> Promise<[Card]>
    func freezeCard(lastFourDigits: String) -> Promise<Card>
    func unfreezeCard(lastFourDigits: String) -> Promise<Card>
    func activateCard(lastFourDigits: String, expiryDate: String?) -> Promise<[Card]>
    func createPin(_ txPin: String?) -> Promise<String>
    func updatePin() -> Promise<Void>
}

public class CardRepository: BaseRepository, CardRepositoryProtocol {
    public func cards() -> Promise<[Card]> {
        return requestAuth(coreAPI.cardAPI(route: .cards))
    }
    
    public func freezeCard(lastFourDigits: String) -> Promise<Card> {
        return requestAuth(coreAPI.cardAPI(route: .block(lastFourDigits)))
    }
    
    public func unfreezeCard(lastFourDigits: String) -> Promise<Card> {
        return requestAuth(coreAPI.cardAPI(route: .activate(lastFourDigits)))
    }
    
    public func activateCard(lastFourDigits: String, expiryDate: String?) -> Promise<[Card]> {
        return requestAuth(coreAPI.cardAPI(route: .enable(lastFourDigits, expiryDate)))
    }
    
    public func createPin(_ txPin: String?) -> Promise<String> {
        return requestAuth(coreAPI.cardAPI(route: .createPin(txPin)))
    }
    
    public func updatePin() -> Promise<Void> {
        return requestAuth(coreAPI.cardAPI(route: .updatePin))
    }
}
