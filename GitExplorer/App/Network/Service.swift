//
//  Service.swift
//  GitExplorer
//
//  Created by Diggo Silva on 14/03/25.
//

import Foundation

protocol ServiceProtocol {
    func getUser(with username: String, completion: @escaping (Result<User, DSError>) -> Void)
    func getRepos(with username: String, completion: @escaping(Result<[Repo], DSError>) -> Void)
}

final class Service: ServiceProtocol {
    
    func getUser(with username: String, completion: @escaping (Result<User, DSError>) -> Void) {
        guard let url = createURL(for: .user(username)) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.invalidUsername))
                    return
                }
                
                guard let _ = response as? HTTPURLResponse else {
                    completion(.failure(.unableToComplete))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let response = try decoder.decode(UserResponse.self, from: data)
                    let user = User(login: response.login,
                                    avatarUrl: response.avatarURL,
                                    name: response.name,
                                    location: response.location,
                                    bio: response.bio,
                                    url: response.url,
                                    htmlURL: response.htmlURL,
                                    publicRepos: response.publicRepos,
                                    publicGists: response.publicGists,
                                    followers: response.followers,
                                    following: response.following,
                                    createdAt: response.createdAt)
                    completion(.success(user))
                    
                } catch {
                    print("Erro de decodificação: \(error.localizedDescription)")
                    completion(.failure(.invalidData))
                }
            }
        }
        task.resume()
    }
    
    func getRepos(with url: String, completion: @escaping(Result<[Repo], DSError>) -> Void) {
        guard let url = createURL(for: .userRepos(url)) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.reposFailed))
                    return
                }
                
                guard let _ = response as? HTTPURLResponse else {
                    completion(.failure(.unableToComplete))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let response = try decoder.decode([ReposResponse].self, from: data)
                    var repos: [Repo] = []
                    
                    for repoResponse in response {
                        let repo = Repo(name: repoResponse.name,
                                        repoDescription: repoResponse.description,
                                        createdAt: repoResponse.createdAt,
                                        updatedAt: repoResponse.updatedAt,
                                        stargazersCount: repoResponse.stargazersCount,
                                        forksCount: repoResponse.forksCount)
                        repos.append(repo)
                    }
                    
                    completion(.success(repos))
                    
                } catch {
                    print("DEBUG: Erro de decodificação: \(error.localizedDescription)")
                    completion(.failure(.invalidData))
                }
            }
        }
        task.resume()
    }
    
    // Função para criar a URL com base no tipo de endpoint
    private func createURL(for endpoint: GitHubEndpoint) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = endpoint.path
        return urlComponents.url
    }
}
