//
//  ProfileViewModel.swift
//  GitExplorer
//
//  Created by Diggo Silva on 16/03/25.
//

import Foundation

protocol ProfileViewModelProtocol {
    var user: User { get }
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
}
