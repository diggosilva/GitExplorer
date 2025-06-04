//
//  SearchViewModel.swift
//  GitExplorer
//
//  Created by Diggo Silva on 14/03/25.
//

import Foundation
import Combine

enum SearchViewControllerStates {
    case searching
    case founded
    case notFound
}

protocol StatefulViewModel {
    associatedtype State
    var statePublisher: AnyPublisher<State, Never> { get }
}

protocol SearchViewModelProtocol: StatefulViewModel where State == SearchViewControllerStates {
    func searchUser(completion: @escaping(Result<String, DSError>) -> Void)
    func fetchUser(username: String)
}

class SearchViewModel: SearchViewModelProtocol {
    
    var searchButtonEnabled: Bool = false
    var user: User?
    
    private let service: ServiceProtocol!
    @Published private var state: SearchViewControllerStates = .searching
    
    var statePublisher: AnyPublisher<SearchViewControllerStates, Never> {
        $state.eraseToAnyPublisher()
    }
    
    var searchText: String = "" {
        didSet {
            searchButtonEnabled = !searchText.isEmpty
        }
    }

    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    func searchUser(completion: @escaping(Result<String, DSError>) -> Void) {
        if searchText.isEmpty {
            completion(.failure(.invalidSearchEmpty))
            state = .notFound
            return
        }
        
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            completion(.failure(.invalidSearchWhiteSpace))
            state = .notFound
            return
        }
        
        completion(.success("Usuário encontrado!"))
        state = .founded
    }
    
    func fetchUser(username: String) {
        state = .searching
        
        service.getUser(with: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.user = user
                self.state = .founded

            case .failure(let error):
                print("DEBUG: Error: \(error.rawValue)")
                self.state = .notFound
            }
        }
    }
}
