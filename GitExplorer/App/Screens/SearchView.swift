//
//  SearchView.swift
//  GitExplorer
//
//  Created by Diggo Silva on 14/03/25.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func didChangeSearchText(to text: String)
    func didTapSearchButton()
}

class SearchView: UIView {
    
    lazy var logoImageView = DSViewBuilder.buildImageView(image: Images.logo)
    
    lazy var titleLabel = DSViewBuilder.buildLabel(text: "Git Explorer", textAlignment: .center)
    
    lazy var searchTextField = DSViewBuilder.buildTextField(placeholder: "Digite o nome do usuário...", selector:  #selector(searchTextChanged(_:)))
    
    lazy var searchButton = DSViewBuilder.buildButton(
        title: "Buscar Usuário", color: .systemGreen, image: SFSymbols.search, isEnabled: false, selector: #selector(searchButtonTapped)
    )
    
    weak var delegate: SearchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    @objc private func searchTextChanged(_ textField: UITextField) {
        delegate?.didChangeSearchText(to: textField.text ?? "")
    }
    
    @objc private func searchButtonTapped() {
        delegate?.didTapSearchButton()
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .systemBackground
        addSubviews(logoImageView, titleLabel, searchTextField, searchButton)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            searchTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            
            searchButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100),
            searchButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
