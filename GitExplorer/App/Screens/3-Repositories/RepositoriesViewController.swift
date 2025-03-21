//
//  RepositoriesViewController.swift
//  GitExplorer
//
//  Created by Diggo Silva on 17/03/25.
//

import UIKit

class RepositoriesViewController: UIViewController {
    
    let repoView = RepositoriesView()
    let viewModel: RepositoriesViewModelProtocol
    
    init(viewModel: RepositoriesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        super.loadView()
        view = repoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureDelegatesAndDataSources()
        handleStates()
        viewModel.fetchRepos()
    }
    
    private func configureNavigationBar() {
        title = "Repositórios"
    }
    
    private func configureDelegatesAndDataSources() {
        repoView.tableView.delegate = self
        repoView.tableView.dataSource = self
    }
    
    private func handleStates() {
        viewModel.state.bind { state in
            switch state {
            case .searching: self.showSearchingState()
            case .founded: self.showFoundedState()
            case .notFound: self.showNotFoundState()
            }
        }
    }
    
    private func showSearchingState() {
        handleSpinner(isLoading: true)
    }
    
    private func showFoundedState() {
        handleSpinner(isLoading: false)
        setNeedsUpdateContentUnavailableConfiguration()
    }
    
    private func handleSpinner(isLoading: Bool) {
        if isLoading {
            repoView.spinner.startAnimating()
            repoView.loadingLabel.isHidden = false
        } else {
            repoView.spinner.stopAnimating()
            repoView.loadingLabel.isHidden = true
            repoView.tableView.reloadData()
            setNeedsUpdateContentUnavailableConfiguration()
        }
    }
    
    private func showNotFoundState() {
        presentDSAlert(title: "Ops... algo deu errado!", message: DSError.reposFailed.rawValue)
        handleSpinner(isLoading: false)
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if viewModel.numberOrRowInSection() == 0 && !repoView.spinner.isAnimating {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "folder")
            config.text = "Sem Repositórios"
            config.secondaryText = "Esse usuário ainda não possui nenhum repositório!"
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
    }
}

extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOrRowInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoriesCell.identifier, for: indexPath) as? RepositoriesCell else { return UITableViewCell() }
        cell.configure(repo: viewModel.cellForRow(at: indexPath))
        return cell
    }
}
