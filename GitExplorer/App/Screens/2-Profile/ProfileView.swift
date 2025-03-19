//
//  ProfileView.swift
//  GitExplorer
//
//  Created by Diggo Silva on 16/03/25.
//

import UIKit
import SDWebImage

class ProfileView: UIView {
    
    lazy var headerView = DSHeaderView()
    lazy var infoViewOne = DSItemInfoViewOne()
    lazy var infoViewTwo = DSItemInfoViewTwo()
    lazy var dateLabel = DSViewBuilder.buildLabel(textColor: .secondaryLabel, textAlignment: .center, font: .preferredFont(forTextStyle: .body))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(user: User) {
        configHeader(user: user)
        configViewOne(user: user)
        configViewTwo(user: user)
    }
    
    func configHeader(user: User) {
        guard let url = URL(string: user.avatarUrl) else { return }
        
        headerView.avatarImageView.sd_setImage(with: url)
        headerView.loginLabel.text = user.login
        headerView.nameLabel.text = user.name
        headerView.locationLabel.text = user.location
        headerView.bioLabel.text = user.bio
    }
    
    func configViewOne(user: User) {
        infoViewOne.countLabelOne.text = String(user.publicRepos)
        infoViewOne.countLabelTwo.text = String(user.publicGists)
    }
    
    func configViewTwo(user: User) {
        infoViewTwo.countLabelOne.text = String(user.followers)
        infoViewTwo.countLabelTwo.text = String(user.following)
        dateLabel.text = "GitHub desde \(user.createdAt.formatDate())"
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .systemBackground
        addSubviews(headerView, infoViewOne, infoViewTwo, dateLabel)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 20
        let heightInfoView: CGFloat = 150
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            
            infoViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            infoViewOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            infoViewOne.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            infoViewOne.heightAnchor.constraint(equalToConstant: heightInfoView),
            
            infoViewTwo.topAnchor.constraint(equalTo: infoViewOne.bottomAnchor, constant: padding),
            infoViewTwo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            infoViewTwo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            infoViewTwo.heightAnchor.constraint(equalToConstant: heightInfoView),
            
            dateLabel.topAnchor.constraint(equalTo: infoViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }
}
