struct CardBuilder {
    static func card(dto: CardDTO?) -> Card? {
        guard let dto = dto else { return nil }
        
        var updatedDate: Date?
        var createdDate: Date?
        var hasATMPin: Bool = true
        var trackingStatus = TrackingStatus.delivered
        
        if let date = dto.updatedDate {
            updatedDate = Date.fromShortedString(date)
        }
        
        if let date = dto.createdDate {
            createdDate = Date.fromShortedString(date)
        }
        
        if let tracking = dto.trackingStatus, !tracking.isEmpty {
            trackingStatus = TrackingStatus(safeRawValue: tracking)
        }
        
        if let hasPin = dto.hasATMPin {
            hasATMPin = (hasPin as NSString).boolValue
        }
        
        return Card(identifier: dto.cardId,
                    last4Digits: dto.last4Digits ?? "",
                    printedName: dto.printedName,
                    status: CardStatus(safeRawValue: dto.status),
                    trackingStatus: trackingStatus,
                    trackingCode: dto.trackingCode,
                    updatedDate: updatedDate,
                    createdDate: createdDate,
                    hasATMPin: hasATMPin,
                    type: self.getDefaultCardType(cardTypeValue: dto.type ?? ""),
                    isRestricted: dto.isRestricted,
                    isReadyToUseVirtualCard: true,
                    isReplacement: false)
    }
    
    /// Converts a `ProductDTO` to a `Card` model for reusability in the module
    static func card(dto: ProductDTO?) -> Card? {
        guard let dto = dto, dto.productType == .card else { return nil }
        let updatedDate: Date? = Date()
        let createdDate: Date? = Date()
        // The tracking functionality is yet to be implemented for now this workaround
        // is to show the different states of the "Card" module
        let trackingStatus = dto.productStatus == .created ? TrackingStatus.delivering : TrackingStatus.delivered
        
        return Card(identifier: dto.cardId,
                    last4Digits: dto.cardNumber,
                    printedName: "",
                    status: CardStatus(safeRawValue: dto.productStatus.rawValue),
                    trackingStatus: trackingStatus,
                    trackingCode: "",
                    updatedDate: updatedDate,
                    createdDate: createdDate,
                    hasATMPin: dto.hasPin,
                    type: self.getDefaultCardType(cardTypeValue: ""),
                    isRestricted: false,
                    isReadyToUseVirtualCard: true,
                    isReplacement: false)
    }
    
    static func card(dto: CardDTOCOL?) -> Card? {
        guard let dto = dto else { return nil }
        
        // Double to Date
        let updatedDateDouble = TimeInterval(dto.updatedDate) / 1000
        let updatedDate = Date(timeIntervalSince1970: updatedDateDouble)
        let createdDateDouble = TimeInterval(dto.createdDate) / 1000
        let createdDate = Date(timeIntervalSince1970: createdDateDouble)
        // Placing both (status == .created) and isRestricted for now so nothing is broken until the full change is done
        let trackingStatus = (CardStatus(safeRawValue: dto.status) == .created || dto.isRestricted) ?  TrackingStatus.delivering : TrackingStatus.delivered
        
        var pin = false
        // Placing both for now so nothing is broken until the full change is done
        if let hasPin = dto.hasPin {
            pin = hasPin
        }
        if let hasATMPin = dto.hasATMPin {
            pin = hasATMPin
        }
        
        return Card(identifier: dto.cardId,
                    last4Digits: dto.last4Digits,
                    printedName: "",
                    status: CardStatus(safeRawValue: dto.status),
                    trackingStatus: trackingStatus,
                    trackingCode: dto.trackingCode ?? "",
                    updatedDate: updatedDate,
                    createdDate: createdDate,
                    hasATMPin: pin,
                    type: self.getDefaultCardType(cardTypeValue: dto.type ?? ""),
                    isRestricted: dto.isRestricted,
                    isReadyToUseVirtualCard: dto.isReadyToUseVirtualCard ?? true,
                    isReplacement: dto.isReplacement ?? false)
    }
    
    private static func getDefaultCardType(cardTypeValue: String, environment: Environment = ServiceLocator.inject()) -> CardType {
        if cardTypeValue.isEmpty {
            guard let protocolEnvironment = environment as? CardBuilderProtocol else {
                return CardType(safeRawValue: cardTypeValue)
            }
            return protocolEnvironment.defaultCardType
        } else {
            return CardType(safeRawValue: cardTypeValue)
        }
    }
}

protocol CardBuilderProtocol {
    var defaultCardType: CardType { get }
}

extension Argentina: CardBuilderProtocol {
    var defaultCardType: CardType {
        return .magnetic
    }
}

extension Mexico: CardBuilderProtocol {
    var defaultCardType: CardType {
        return .chip
    }
}

extension MexicoABC: CardBuilderProtocol {
    var defaultCardType: CardType {
        return .chip
    }
}

extension Colombia: CardBuilderProtocol {
    var defaultCardType: CardType {
        return .physical
    }
}
