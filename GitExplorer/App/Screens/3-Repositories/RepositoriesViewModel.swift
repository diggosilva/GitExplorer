//
//  RepositoriesViewModel.swift
//  GitExplorer
//
//  Created by Diggo Silva on 17/03/25.
//

import Foundation
import Combine

enum RepositoriesViewControllerStates {
    case searching
    case founded
    case notFound
}

protocol RepositoriesViewModelProtocol: StatefulViewModel where State == RepositoriesViewControllerStates {
    func numberOrRowInSection() -> Int
    func cellForRow(at indexPath: IndexPath) -> Repo
    func fetchRepos()
}

class RepositoriesViewModel: RepositoriesViewModelProtocol {
    
    var user: User
    var repos: [Repo] = []
    
    @Published private var state: RepositoriesViewControllerStates = .searching
    
    var statePublisher: AnyPublisher<RepositoriesViewControllerStates, Never> {
        $state.eraseToAnyPublisher()
    }
    
    private let service: ServiceProtocol!
    
    init(user: User, service: ServiceProtocol = Service()) {
        self.user = user
        self.service = service
    }
    
    func numberOrRowInSection() -> Int {
        return repos.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> Repo {
        return repos[indexPath.row]
    }
    
    func fetchRepos() {
        guard !user.login.isEmpty else {
            state = .notFound
            return
        }
        
        state = .searching
        
        service.getRepos(with: user.login) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let repos):
                self.repos.append(contentsOf: repos)
                state = .founded
                
            case .failure(let error):
                print("DEBUG: Error: \(error.rawValue)")
                state = .notFound
            }
        }
    }
}
