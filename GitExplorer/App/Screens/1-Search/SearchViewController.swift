//
//  SearchViewController.swift
//  GitExplorer
//
//  Created by Diggo Silva on 13/03/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchView = SearchView()
    let viewModel = SearchViewModel()
    
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegatesAndDataSources()
        handleStates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchView.searchButton.isEnabled = false
        searchView.searchTextField.text = ""
        searchView.searchTextField.becomeFirstResponder()
    }
    
    private func configureDelegatesAndDataSources() {
        searchView.delegate = self
        searchView.searchTextField.delegate = self
    }
    
    private func handleStates() {
        viewModel.state.bind { state in
            
            switch state {
            case .searching:
                self.showSearchingState()
                
            case .founded:
                self.showFoundedState()
                
            case .notFound:
                self.showNotFoundState()
            }
        }
    }
    
    private func showSearchingState() {}
    
    private func showFoundedState() {
        guard let user = viewModel.user else {
            presentDSAlert(title: "Ops... algo deu errado!", message: DSError.invalidUsername.rawValue)
            return
        }
        
        let profileVC = ProfileViewController(viewModel: ProfileViewModel(user: user))
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func showNotFoundState() {
        presentDSAlert(title: "Ops... algo deu errado!", message: DSError.invalidUsername.rawValue)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func pushProfileViewController() {
        let username = searchView.searchTextField.text ?? ""
        viewModel.fetchUser(username: username)
    }
}

extension SearchViewController: SearchViewDelegate, UITextFieldDelegate {
    func didChangeSearchText(to text: String) {
        if text.trimmingCharacters(in: .whitespaces).isEmpty {
            searchView.searchButton.isEnabled = false
        } else {
            searchView.searchButton.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushProfileViewController()
        return true
    }
    
    func didTapSearchButton() {
        pushProfileViewController()
    }
}
