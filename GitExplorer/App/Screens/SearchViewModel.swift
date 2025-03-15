class SearchViewModel: SearchViewModelProtocol {
    
    var state: Bindable<SearchViewControllerStates> = Bindable(value: .searching)
    
    var searchButtonEnabled: Bool = false
    
    var searchText: String = "" {
        didSet {
            searchButtonEnabled = !searchText.isEmpty
        }
    }
    
    var username: String = ""
    
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
                self.state.value = .founded
                
            case .failure(let error):
                print("DEBUG: Error: \(error.rawValue)")
                self.state.value = .notFound
            }
        }
    }
}
