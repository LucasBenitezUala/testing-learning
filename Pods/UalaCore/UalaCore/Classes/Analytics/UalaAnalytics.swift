public protocol Analytics {
    func trackUser(name: String)
    func trackEvent(_ event: Event)
    func trackScreen(_ event: Event)
    func trackRevenue(_ revenue: Revenue)
    func trackAttribute(_ attribute: Attribute)
    
    /// This method should be used when we want to send an event with a value property with a specific event name.
    /// The main difference with #sendRevenue is that it maintains the event name.
    /// The main difference with #sendEvent is that it keeps the reserved key property for values.
    func trackRevenueCustom(_ revenue: RevenueCustom)
}

public extension Analytics {
    func trackAttribute(_ attribute: Attribute) { }

    func trackRevenueCustom(_ revenue: RevenueCustom) {
        print(#function + " not was implement in \(self)")
    }
}
