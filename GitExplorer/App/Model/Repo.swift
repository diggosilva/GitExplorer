//
//  Repo.swift
//  GitExplorer
//
//  Created by Diggo Silva on 17/03/25.
//

import Foundation

class Repo: Codable {
    let name: String
    let repoDescription: String?
    let createdAt: Date
    let updatedAt: Date
    let stargazersCount: Int
    let forksCount: Int
    
    init(name: String, repoDescription: String?, createdAt: Date, updatedAt: Date, stargazersCount: Int, forksCount: Int) {
        self.name = name
        self.repoDescription = repoDescription
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.stargazersCount = stargazersCount
        self.forksCount = forksCount
    }
}
