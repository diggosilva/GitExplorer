//
//  Service.swift
//  GitExplorer
//
//  Created by Diggo Silva on 14/03/25.
//

import Foundation

protocol ServiceProtocol {
    func getUser(with username: String) async throws -> User
    func getRepos(with username: String) async throws -> [Repo]
}

final class Service: ServiceProtocol {
    func getUser(with username: String) async throws -> User {
        
        guard let url = createURL(for: .user(username)) else {
            throw DSError.invalidUsername
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // É essencial verificar a resposta HTTP *antes* de tentar decodificar os dados
            guard let httpResponse = response as? HTTPURLResponse else {
                throw DSError.unableToComplete
            }
    
            // Apenas continue se o status for 200 OK
            guard httpResponse.statusCode == 200 else {
                print("DEBUG: StatusCode: \(httpResponse.statusCode)")
                throw DSError.unableToComplete
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let userResponse = try decoder.decode(UserResponse.self, from: data)
            
            let user = User(login: userResponse.login,
                            avatarUrl: userResponse.avatarURL,
                            name: userResponse.name,
                            location: userResponse.location,
                            bio: userResponse.bio,
                            url: userResponse.url,
                            htmlURL: userResponse.htmlURL,
                            publicRepos: userResponse.publicRepos,
                            publicGists: userResponse.publicGists,
                            followers: userResponse.followers,
                            following: userResponse.following,
                            createdAt: userResponse.createdAt)
            return user
            
        } catch let urlError as URLError {
            // Captura erros específicos da rede (offline, timeout, etc.)
            print("DEBUG: Erro de rede: \(urlError.localizedDescription)")
            throw DSError.invalidData
            
        } catch {
            // Captura erros de decodificação ou outros erros inesperados
            print("DEBUG: Erro de decodificação ou outro erro inesperado: \(error.localizedDescription)")
            throw DSError.invalidResponse
        }
    }
    
    func getRepos(with username: String) async throws -> [Repo] {
        guard let url = createURL(for: .userRepos(username)) else {
            throw DSError.invalidUsername
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw DSError.unableToComplete
            }
            
            guard httpResponse.statusCode == 200 else {
                print("DEBUG: StatusCode para repos: \(httpResponse.statusCode)")
                throw DSError.unableToComplete
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let repoResponses = try decoder.decode([ReposResponse].self, from: data)
            
            // Mapeando [ReposResponse] para [Repo]
            let repos = repoResponses.map { repoResponse in
                Repo(name: repoResponse.name,
                     repoDescription: repoResponse.description,
                     createdAt: repoResponse.createdAt,
                     updatedAt: repoResponse.updatedAt,
                     stargazersCount: repoResponse.stargazersCount,
                     forksCount: repoResponse.forksCount)
            }
            return repos
            
        } catch let urlError as URLError {
            print("DEBUG: Erro de rede ao buscar repos: \(urlError.localizedDescription)")
            throw DSError.invalidData
            
        } catch {
            print("DEBUG: Erro de decodificação ou outro erro inesperado ao buscar repos: \(error.localizedDescription)")
            throw DSError.invalidResponse
        }
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
