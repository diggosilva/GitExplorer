//
//  ProfileViewController.swift
//  GitExplorer
//
//  Created by Diggo Silva on 16/03/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    var viewModel: ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        super.loadView()
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureDelegatesAndDataSources()
        configureProfileViewWithUser()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector (dismissProfile))
    }
    
    private func configureDelegatesAndDataSources() {
        profileView.infoViewOne.delegate = self
        profileView.infoViewTwo.delegate = self
    }
    
    @objc func dismissProfile() {
        dismiss(animated: true)
    }
    
    private func configureProfileViewWithUser() {
        profileView.configure(user: viewModel.user)
    }
}

extension ProfileViewController: DSItemInfoViewOneDelegate, DSItemInfoViewTwoDelegate {
    func didTapRepoButton() {
        let user = viewModel.user
        let repoVC = RepositoriesViewController(viewModel: RepositoriesViewModel(user: user))
        navigationController?.pushViewController(repoVC, animated: true)
    }
    
    func didTapProfileButton() {
        print("DEBUG: Mostrar Perfil do GitHub")
    }
}
