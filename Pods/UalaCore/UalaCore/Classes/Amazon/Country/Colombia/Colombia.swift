public class Colombia: Environment {
    public var name: String = "Colombia"
    public var id = "CO"
    public lazy var credentials: Credentials = Auth()
    public var coreAPI: API = API(ColombiaAPIManager())
    public var amazon: AmazonConfiguration = DefaultAmazonConfiguration()
    public var localeIdentifier = "es_CO"
    public let currencyCode = "COP"
}
