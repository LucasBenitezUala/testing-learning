//
//  HomePresenter.swift
//  HomeExample
//
//  Created by Francisco Javier Saldivar Rubio on 29/10/22.
//

final class HomePresenter {
    
    private let interactor: HomeInteractor = HomeInteractor()
    private let router: HomeRouter = HomeRouter()
    weak var view: HomeViewController?
    var task: Task<Void, Error>?
    
    deinit {
        task?.cancel()
    }
}

extension HomePresenter {
    
    func homeStarted() {
        task = Task {
            await getBalance()
            await getUser()
        }
    }
    
    @MainActor
    func getBalance() {
        interactor.getBalance { [weak self] result in
            switch result {
            case .success(let balance):
                self?.view?.setBalance(amount: balance.availableBalance)
            case .failure(let error):
                print("💥: \(error)")
            }
        }
    }
    
    @MainActor
    func getUser() {
        interactor.getUser { result in
            switch result {
            case .success(let user):
                let userID = user.userId ?? ""
                let name = user.fullName ?? ""
                print("👤: \n userID: \(userID) \n name: \(name) \n email: \(user.email)")
            case .failure(let error):
                print("💥: \(error)")
            }
        }
    }
    
    func unLogged() {
        
    
        task = Task {
            await router.goToLogin()
        }
    }
    
}
