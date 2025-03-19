enum GitHubEndpoint {
    case user(String)
    case userRepos(String)
    
    var path: String {
        switch self {
        case .user(let username):
            return "/users/\(username)"
        case .userRepos(let username):
            return "/users/\(username)/repos"
        }
    }
}
