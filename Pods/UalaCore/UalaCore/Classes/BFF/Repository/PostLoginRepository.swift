//
//  PostLoginRepository.swift
//  Uala
//
//  Created by Luis Perez on 08/04/22.
//  Copyright © 2022 Ualá. All rights reserved.
//

import UalaCore

public protocol PostLoginRepository: AnyObject {
    func loadAccountInfo() async throws -> Account
}

public final class DefaultPostLoginRepository: PostLoginRepository {
    private let localDatasource: PostLoginLocalDataSourceType
    private let apiClient: AsyncRepository
    
    public init(localDatasource: PostLoginLocalDataSourceType,
         apiClient: AsyncRepository) {
        self.localDatasource = localDatasource
        self.apiClient = apiClient
    }
    
    public func loadAccountInfo() async throws -> Account {
        if let account = await loadLocalAccount() {
            return account
        }
        return try await loadRemoteAccount()
    }
    
    private func loadLocalAccount() async -> Account? {
        return  await withCheckedContinuation { continuation in
            _ = localDatasource.getInfo().sink { _ in } receiveValue: { value in
                continuation.resume(returning: value)
            }
        }
    }
    
    private func loadRemoteAccount() async throws -> Account {
        let userAccount = try await apiClient.request(request: PostLoginAPIRequest(),
                                                      responseType: PostLoginResponse.self,
                                                      retries: 0).mapToPostLoginInfo()
        await saveAccount(account: userAccount)
        return userAccount
    }
    
    @MainActor
    private func saveAccount(account: Account) {
        _ = localDatasource.save(account)
    }
}
