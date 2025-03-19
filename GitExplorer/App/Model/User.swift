//
//  User.swift
//  GitExplorer
//
//  Created by Diggo Silva on 14/03/25.
//

import Foundation

class User: Codable, CustomStringConvertible {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let url: String
    let htmlURL: String
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: Date
    
    init(login: String, avatarUrl: String, name: String? = nil, location: String? = nil, bio: String? = nil, url: String, htmlURL: String, publicRepos: Int, publicGists: Int, followers: Int, following: Int, createdAt: Date) {
        self.login = login
        self.avatarUrl = avatarUrl
        self.name = name
        self.location = location
        self.bio = bio
        self.url = url
        self.htmlURL = htmlURL
        self.publicRepos = publicRepos
        self.publicGists = publicGists
        self.followers = followers
        self.following = following
        self.createdAt = createdAt
    }
    
    var description: String {
        return "User(login: \(login), avatarUrl: \(avatarUrl), name: \(name ?? ""), location: \(location ?? ""), bio: \(bio ?? ""), url: \(url), htmlURL: \(htmlURL), publicRepos: \(publicRepos), publicGists: \(publicGists), followers: \(followers), following: \(following), createdAt: \(createdAt))"
    }
}
