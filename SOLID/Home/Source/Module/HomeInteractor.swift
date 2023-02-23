//
//  HomeInteractor.swift
//  HomeExample
//
//  Created by Francisco Javier Saldivar Rubio on 29/10/22.
//

import UalaCore

final class HomeInteractor {
    
    private let profileRepo: ProfileRepository = .init()
}

extension HomeInteractor {
    
    func getBalance(completion: @escaping (Result<Balance, Error>) -> Void) {
        profileRepo.balance().done { balance in
            UserSessionData.balance = balance
            completion(.success(balance))
        }.catch { error in
            completion(.failure(error))
        }
    }
    
    func getUser(completion: @escaping (Result<User, Error>) -> Void) {
        profileRepo.details().done { user in
            UserSessionData.user = user
            completion(.success(user))
        }.catch { error in
            completion(.failure(error))
        }
    }
}
