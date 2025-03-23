//
//  RepositoriesViewModel.swift
//  GitExplorer
//
//  Created by Diggo Silva on 17/03/25.
//

import Foundation

enum RepositoriesViewControllerStates {
    case searching
    case founded
    case notFound
}

protocol RepositoriesViewModelProtocol {
    func numberOrRowInSection() -> Int
    func cellForRow(at indexPath: IndexPath) -> Repo
    func fetchRepos()
    var state: Bindable<RepositoriesViewControllerStates> { get }
}

class RepositoriesViewModel: RepositoriesViewModelProtocol {
    
    var state: Bindable<RepositoriesViewControllerStates> = Bindable(value: .searching)
    var user: User
    var repos: [Repo] = []
    
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
            state.value = .notFound
            return
        }
        
        state.value = .searching
        
        service.getRepos(with: user.login) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let repos):
                self.repos.append(contentsOf: repos)
                state.value = .founded
                
            case .failure(let error):
                print("DEBUG: Error: \(error.rawValue)")
                state.value = .notFound
            }
        }
    }
}
