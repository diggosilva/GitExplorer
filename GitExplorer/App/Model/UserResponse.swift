//
//  UserResponse.swift
//  GitExplorer
//
//  Created by Diggo Silva on 14/03/25.
//

import Foundation

struct UserResponse: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String?
    let url: String
    let htmlURL: String
    let followersURL: String
    let followingURL: String
    let gistsURL: String
    let starredURL: String
    let subscriptionsURL: String
    let organizationsURL: String
    let reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let userViewType: String
    let siteAdmin: Bool
    let name: String? // Opcional, pois pode ser null
    let company: String? // Opcional
    let blog: String? // Opcional
    let location: String? // Opcional
    let email: String? // Opcional
    let hireable: Bool? // Já está opcional
    let bio: String? // Opcional
    let twitterUsername: String? // Opcional
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: Date
    let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case userViewType = "user_view_type"
        case siteAdmin = "site_admin"
        case name, company, blog, location, email, hireable, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
