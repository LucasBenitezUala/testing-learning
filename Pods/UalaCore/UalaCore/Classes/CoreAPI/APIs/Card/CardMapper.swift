import Foundation

struct CardsMapper: MappeableType {
    
    struct Result: Decodable {
        let cards: [CardDTO]
    }
    
    func map<T>(_ data: Data) -> T? {
        return decode(data)?
            .cards
            .compactMap({ CardBuilder.card(dto: $0) }) as? T
    }
}

struct DefaultCardsMapper: MappeableType {
    
    struct Result: Decodable {
        let products: [ProductDTO]
    }
    
    func map<T>(_ data: Data) -> T? {
        return decode(data)?
            .products
            .compactMap({ CardBuilder.card(dto: $0) }) as? T
    }
}

struct CardMapper: MappeableType {
    
    struct Result: Decodable {
        let card: CardDTO
    }
    
    func map<T>(_ data: Data) -> T? {        
        return CardBuilder.card(dto: decode(data)?.card) as? T
    }
}

struct CardMapperCol: MappeableType {
    
    struct Result: Decodable {
        let cards: [CardDTOCOL]
    }
    
    func map<T>(_ data: Data) -> T? {
        return decode(data)?
            .cards
            .compactMap({ CardBuilder.card(dto: $0) }) as? T
    }
}
/*
 In MEX, the activation WS returns a single card (not an array as in arg):
 https://bancar.atlassian.net/wiki/spaces/UM/pages/1428685093/Activate+Card
 but the app expects an array for both cases. Please do this better :(
 */
struct MxEnableCardMapper: MappeableType {
    
    struct Result: Decodable {
        let card: CardDTO
    }
    
    func map<T>(_ data: Data) -> T? {
        return [CardBuilder.card(dto: decode(data)?.card)] as? T
    }
}

struct CreateATMPinMapper: MappeableType {
    struct Result: Decodable {
        let url: String
    }

    func map<T>(_ data: Data) -> T? {
        guard let url = decode(data)?.url else { return nil }
        return url as? T
    }
}

struct NipMapper: MappeableType {
    struct NipImageDTO: Decodable {
        let image: String
    }
    
    typealias Result = NipImageDTO
    func map<T>(_ data: Data) -> T? {
            return decode(data)?.image as? T
    }
}

struct CardTrackingNumberMapper: MappeableType {
    
    struct Result: Decodable {
        let cards: [CardDTO]
    }
    
    func map<T>(_ data: Data) -> T? {
        return decode(data)?
            .cards
            .compactMap({ CardBuilder.card(dto: $0) }).first?.trackingCode as? T
    }
}

public struct EmptyMapper: MappeableType {
    public typealias Result = EmptyResponse
    
    public init() {
        // This empty initializer is required for exposure.
    }
    
    public func map<T>(_ data: Data) -> T? {
        return () as? T
    }
}

public struct EmptyResponse: Decodable {
    init() {}
}
