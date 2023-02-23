import Foundation

public class UserMapper {
    
    public static func map(from dto: RemoteUser.User) -> User {
        let environment: Environment = CoreEnvironment.shared.environment
        guard let userMapper: UserMapperDependenciesProtocol = environment as? UserMapperDependenciesProtocol else { return User(email: "") }
        return userMapper.map(from: dto)
    }
}
