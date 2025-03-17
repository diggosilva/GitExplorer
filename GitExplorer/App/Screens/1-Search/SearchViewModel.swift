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
    func fetchUser()
}

class SearchViewModel: SearchViewModelProtocol {
    
    var state: Bindable<SearchViewControllerStates> = Bindable(value: .searching)
    
    var searchButtonEnabled: Bool = false
    
    var searchText: String = "" {
        didSet {
            searchButtonEnabled = !searchText.isEmpty
        }
    }
    
    var username: String = ""
    var user: User?
    
    private let service: ServiceProtocol!
    
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
    
    func fetchUser() {
        service.getUser(with: username) { result in
            switch result {
            case .success(let username):
                self.username = username.login
                self.user = username
                
                guard let user = self.user else {
                    print("DEBUG: Usuário não encontrado")
                    self.state.value = .notFound
                    return
                }
                
                print("DEBUG: \(user)")
                self.state.value = .founded

            case .failure(let error):
                print("DEBUG: Error: \(error.rawValue)")
                self.state.value = .notFound
            }
        }
    }
}
