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
    func searchUserPublisher() -> AnyPublisher<String, DSError>
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
    
    func searchUserPublisher() -> AnyPublisher<String, DSError> {
        Future { [weak self] promise in
            guard let self = self else { return }
            
            if self.searchText.isEmpty {
                self.state = .notFound
                promise(.failure(.invalidSearchEmpty))
                return
            }
            
            if self.searchText.trimmingCharacters(in: .whitespaces).isEmpty {
                self.state = .notFound
                promise(.failure(.invalidSearchWhiteSpace))
                return
            }
            
            self.state = .founded
            promise(.success("Usuário encontrado!"))
        }
        .eraseToAnyPublisher()
    }
    
    func fetchUser(username: String) {
        state = .searching
        
        Task { @MainActor in
            do {
                let user = try await service.getUser(with: username)
                self.user = user
                self.state = .founded
            } catch {
                print("DEBUG: Error fetching user: \(error.localizedDescription)")
                self.state = .notFound
            }
        }
    }
}
