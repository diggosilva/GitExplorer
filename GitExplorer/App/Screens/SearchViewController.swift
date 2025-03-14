//
//  SearchViewController.swift
//  GitExplorer
//
//  Created by Diggo Silva on 13/03/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureDelegatesAndDataSources()
    }
    
    private func configureNavigationBar() {
        title = "Buscar Usuário"
    }
    
    private func configureDelegatesAndDataSources() {
        
    }
}
