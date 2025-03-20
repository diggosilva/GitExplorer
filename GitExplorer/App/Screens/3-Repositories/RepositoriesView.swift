//
//  RepositoriesView.swift
//  GitExplorer
//
//  Created by Diggo Silva on 17/03/25.
//

import UIKit

class RepositoriesView: UIView {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.backgroundColor = .secondarySystemBackground
        tv.register(RepositoriesCell.self, forCellReuseIdentifier: RepositoriesCell.identifier)
        return tv
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    lazy var loadingLabel = DSViewBuilder.buildLabel(text: "Carregando repositórios...", textColor: .secondaryLabel, textAlignment: .center, font: .preferredFont(forTextStyle: .subheadline))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .systemBackground
        addSubviews(tableView, spinner, loadingLabel)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loadingLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: padding),
            loadingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            loadingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }
}
