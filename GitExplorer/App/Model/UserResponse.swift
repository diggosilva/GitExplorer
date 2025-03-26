//
//  UserResponse.swift
//  GitExplorer
//
//  Created by Diggo Silva on 14/03/25.
//

import Foundation

struct UserResponse: Codable {
    let login: String
    let avatarURL: String
    let url: String
    let htmlURL: String
    let name: String?
    let location: String?
    let bio: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case url
        case htmlURL = "html_url"
        case name, location, bio
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
    }
}
