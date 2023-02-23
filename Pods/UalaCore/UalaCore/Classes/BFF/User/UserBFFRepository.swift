//
//  UserBFFRepository.swift
//  UalaCore
//
//  Created by Matías Schwalb on 06/06/2022.
//

public class UserBFFRepository {
    
    private let apiClient: AsyncRepository
    
    public init(apiClient: AsyncRepository) {
        self.apiClient = apiClient
    }
    
    private func loadUserInfo() async throws -> UserMulticountry {
        let user: UserMulticountry = try await apiClient.request(request: UserBFFAPIRequest(),
                                                                 responseType: UserMulticountry.self,
                                                                 retries: 0)
        
        return user
    }
    
    public func loadSpecialFields() async throws -> UserMulticountrySpecialFields? {
        let user = try await loadUserInfo()
        
        return UserMulticountrySpecialFields.createEntity(from: user)
    }
    
    public func loadCatalog(for type: UserCatalogType) async throws -> [UserCatalog] {
        let catalog: [UserCatalog] = try await apiClient.request(request: UserCatalogBFFAPIRequest(catalog: type),
                                                                    responseType: [UserCatalog].self,
                                                                    retries: 0)
        
        return catalog
    }
}
