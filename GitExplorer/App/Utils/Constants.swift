//
//  Constants.swift
//  GitExplorer
//
//  Created by Diggo Silva on 13/03/25.
//

import UIKit

enum SFSymbols {
    static let search = UIImage(systemName: "magnifyingglass")
    static let location = UIImage(systemName: "mappin.and.ellipse")
    static let fork = UIImage(systemName: "arrow.trianglehead.branch")
    static let repo = UIImage(systemName: "folder")
    static let gist = UIImage(systemName: "text.alignleft")
    static let star = UIImage(systemName: "star")
    static let followers = UIImage(systemName: "heart")
    static let following = UIImage(systemName: "person.2")
    static let ghProfile = UIImage(systemName: "person")
    static let ghFollowers = UIImage(systemName: "person.3")
}

enum InfoItemType: String {
    case repos = "Repos Públicos"
    case gists = "Gists Públicos"
    case followers = "Seguidores"
    case following = "Seguindo"
}

enum Images {
    static let logo = UIImage(resource: .logo)
    static let avatar = UIImage(resource: .avatar)
}
