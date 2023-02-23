import Foundation

class AddressMapper {
    
    private static let provincies = Province.fromLocalBundle()
    
    static func map(from dict: [String: Any]) -> Address? {
        
        let environment: Environment = CoreEnvironment.shared.environment
        
        guard !dict.isEmpty,
              let mapper = environment as? AddressMapperDependenciesProtocol
        else { return nil }
        
        return mapper.map(from: dict)
    }
}
