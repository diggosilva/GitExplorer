//
//  ReposResponse.swift
//  GitExplorer
//
//  Created by Diggo Silva on 17/03/25.
//

import Foundation

// MARK: - ReposResponseElement
struct ReposResponse: Codable {
    let name: String
    let description: String?
    let createdAt, updatedAt: Date
    let stargazersCount: Int
    let forksCount: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
    }
}
