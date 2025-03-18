class RepositoriesViewModel: RepositoriesViewModelProtocol {
    var repos: [Repo] = []
    
    init(repos: [Repo]) {
        self.repos = repos
    }
    
    
    func numberOrRowInSection() -> Int {
        return repos.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> Repo {
        return repos[indexPath.row]
    }
}