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
        
        Task { @MainActor in
            do {
                let repos = try await service.getRepos(with: user.login)
                self.repos.append(contentsOf: repos)
                self.state = .founded
            } catch {
                print("DEBUG: Error: \(error.localizedDescription)")
                state = .notFound
            }
        }
    }
}
