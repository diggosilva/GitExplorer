//
//  SearchViewModel.swift
//  GitExplorer
//
//  Created by Diggo Silva on 14/03/25.
//

import Foundation

enum SearchViewControllerStates {
    case searching
    case founded
    case notFound
}

protocol SearchViewModelProtocol {
    func searchUser(completion: @escaping(Result<String, DSError>) -> Void)
    func fetchUser(username: String)
}

class SearchViewModel: SearchViewModelProtocol {
    
    var state: Bindable<SearchViewControllerStates> = Bindable(value: .searching)
    var searchButtonEnabled: Bool = false
    var user: User?
    
    private let service: ServiceProtocol!
    
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
            state.value = .notFound
            return
        }
        
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            completion(.failure(.invalidSearchWhiteSpace))
            state.value = .notFound
            return
        }
        
        completion(.success("Usuário encontrado!"))
        state.value = .founded
    }
    
    func fetchUser(username: String) {
        state.value = .searching
        
        service.getUser(with: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.user = user
                self.state.value = .founded

            case .failure(let error):
                print("DEBUG: Error: \(error.rawValue)")
                self.state.value = .notFound
            }
        }
    }
}
