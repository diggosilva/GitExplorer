//
//  ProfileViewModelProtocol.swift
//  GitExplorer
//
//  Created by Diggo Silva on 16/03/25.
//


//MARK: VIEW MODEL
protocol ProfileViewModelProtocol {
    var user: User? { get }
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    let user: User?
    
    init(user: User? = nil) {
        self.user = user
    }
}
