import Foundation
import UalaCore

public protocol CardInfoActionProtocol: AnyObject {
    func showChat()
    func showTracking(trackingFromHome: Bool)
    func showActivation()
    func showUnfreeze()
    func showHome()
    func showCharge()
    func whatCanYouDo()
    func showCard()
    func changeCardStatus()
    func showInvestment()
    func contentCardTapped(url: String)
    func showCreateATMPin()
    func showTaxCalculator()
    func showNip()
    func presentAcceptVirtualCardActivation(cardIdentifier: String, isReplacement: Bool)
}

public struct CardInfoAction {
    public var name: String
    public let action: ((CardInfoActionProtocol?) -> Void)
    
    public init(name: String, action: @escaping ((CardInfoActionProtocol?) -> Void) ) {
        self.action = action
        self.name = translate(name)
    }
}

public class CardInfoViewModel: TransactionCellCardInfoProtocol {
    public var id: String?
    public let title: String
    public let subtitle: String
    
    public let icon: String?
    public let urlImage: String?
    public let mainAction: CardInfoAction?
    public let secondaryAction: CardInfoAction?
    
    public init(
        id: String? = nil,
        title: String,
        subtitle: String,
        icon: String? = nil,
        urlImage: String? = nil,
        mainAction: CardInfoAction? = nil,
        secondaryAction: CardInfoAction? = nil
    ) {
        self.id = id
        self.icon = icon
        self.urlImage = urlImage
        self.title = translate(title)
        self.subtitle = translate(subtitle)
        self.mainAction = mainAction
        self.secondaryAction = secondaryAction
    }
}

public extension CardInfoActionProtocol {
    func showChat() {}
    func showTracking(trackingFromHome: Bool) {}
    func showActivation() {}
    func showUnfreeze() {}
    func showHome() {}
    func showCard() {}
    func showCharge() {}
    func whatCanYouDo() {}
    func changeCardStatus() {}
    func showInvestment() {}
    func contentCardTapped(url: String) {}
    func showCreateATMPin() {}
    func showTaxCalculator() {}
    func showNip() {}
    func presentAcceptVirtualCardActivation(cardIdentifier: String, isReplacement: Bool) {}
}
