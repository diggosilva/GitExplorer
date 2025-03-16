//
//  Service.swift
//  GitExplorer
//
//  Created by Diggo Silva on 14/03/25.
//

import Foundation

protocol ServiceProtocol {
    func getUser(with username: String, completion: @escaping (Result<User, DSError>) -> Void)
}

final class Service: ServiceProtocol {
    
    let baseURL = "https://api.github.com/users/"
    
    func getUser(with username: String, completion: @escaping (Result<User, DSError>) -> Void) {
        guard let url = URL(string: baseURL + username) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                
                if error != nil {
                    completion(.failure(.invalidUsername))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
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
                    let user = User(
                        login: response.login,
                        avatarUrl: response.avatarURL,
                        name: response.name,
                        location: response.location,
                        bio: response.bio,
                        htmlUrl: response.htmlURL,
                        publicRepos: response.publicRepos,
                        publicGists: response.publicGists,
                        followers: response.followers,
                        following: response.following,
                        createdAt: response.createdAt
                    )
                    completion(.success(user))
                    
                } catch {
                    print("Erro de decodificação: \(error.localizedDescription)")
                    completion(.failure(.invalidData))
                }
            }
        }
        task.resume()
    }
}
