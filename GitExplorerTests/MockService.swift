//
//  MockService.swift
//  GitExplorerTests
//
//  Created by Diggo Silva on 03/10/25.
//

import XCTest
import Combine
@testable import GitExplorer

class Mock: ServiceProtocol {
    
    var isSuccess: Bool = true
    
    func getUser(with username: String) async throws -> User {
        if isSuccess {
            return User(login: username, avatarUrl: "", url: "", htmlURL: "", publicRepos: 4, publicGists: 3, followers: 2, following: 1, createdAt: Date())
        } else {
            throw DSError.invalidUsername
        }
    }
    
    func getRepos(with username: String) async throws -> [Repo] {
        if isSuccess {
            return [
                Repo(name: "FirstRepo", repoDescription: nil, createdAt: Date(), updatedAt: Date(), stargazersCount: 4, forksCount: 3),
                Repo(name: "SecondRepo", repoDescription: nil, createdAt: Date(), updatedAt: Date(), stargazersCount: 2, forksCount: 1)
            ]
        } else {
            throw DSError.reposFailed
        }
    }
}
