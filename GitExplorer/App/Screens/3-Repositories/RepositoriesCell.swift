//
//  RepositoriesCell.swift
//  GitExplorer
//
//  Created by Diggo Silva on 17/03/25.
//

import UIKit

class RepositoriesCell: UITableViewCell {
    
    static let identifier = "RepositoriesCell"
    
    lazy var containerView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        cv.layer.cornerRadius = 20
        cv.clipsToBounds = true
        return cv
    }()
    
    lazy var repoTitle = DSViewBuilder.buildLabel(textAlignment: .center, font: .boldSystemFont(ofSize: 24))
    lazy var repoDescription = DSViewBuilder.buildLabel(textColor: .secondaryLabel, font: .systemFont(ofSize: 17, weight: .medium), numberOfLines: 2)
    
    lazy var createAtLabel = DSViewBuilder.buildLabel(text: "Criado em", textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    lazy var createAt = DSViewBuilder.buildLabel(textColor: .secondaryLabel, textAlignment: .center, font: .preferredFont(forTextStyle: .subheadline))
    lazy var VStackDate = DSViewBuilder.buildStackView(arrangedSubviews: [createAtLabel, createAt], axis: .vertical, distribution: .fillEqually, alignment: .center, backgroundColor: .systemBackground)
    
    lazy var updateAtLabel = DSViewBuilder.buildLabel(text: "Atualizado em", textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    lazy var updateAt = DSViewBuilder.buildLabel(textColor: .secondaryLabel, textAlignment: .center, font: .preferredFont(forTextStyle: .subheadline))
    lazy var VStackUpdate = DSViewBuilder.buildStackView(arrangedSubviews: [updateAtLabel, updateAt], axis: .vertical, distribution: .fillEqually, alignment: .center, backgroundColor: .systemBackground)
    
    lazy var HStackDates = DSViewBuilder.buildStackView(arrangedSubviews: [VStackDate, VStackUpdate], axis: .horizontal, distribution: .fillEqually, alignment: .center, spacing: 1, backgroundColor: .secondaryLabel)
    
    
    lazy var starImageView = DSViewBuilder.buildIconImageView(image: SFSymbols.star)
    lazy var starLabel = DSViewBuilder.buildLabel(text: "Stars", textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    lazy var HStackStars = DSViewBuilder.buildStackView(arrangedSubviews: [starImageView, starLabel], axis: .horizontal, distribution: .fillEqually, alignment: .center, spacing: 0)
    
    lazy var starCountLabel = DSViewBuilder.buildLabel(textColor: .secondaryLabel, textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    lazy var VStackStars = DSViewBuilder.buildStackView(arrangedSubviews: [HStackStars, starCountLabel], axis: .vertical, distribution: .fillEqually, alignment: .center, backgroundColor: .systemBackground)
    
    lazy var forkImageView = DSViewBuilder.buildIconImageView(image: SFSymbols.fork)
    lazy var forkLabel = DSViewBuilder.buildLabel(text: "Forks", textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    lazy var HStackForks = DSViewBuilder.buildStackView(arrangedSubviews: [forkImageView, forkLabel], axis: .horizontal, distribution: .fillEqually, alignment: .center, spacing: 0)
    
    lazy var forkCountLabel = DSViewBuilder.buildLabel(textColor: .secondaryLabel, textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    lazy var VStackForks = DSViewBuilder.buildStackView(arrangedSubviews: [HStackForks, forkCountLabel], axis: .vertical, distribution: .fillEqually, alignment: .center, backgroundColor: .systemBackground)
    
    lazy var HStackStarsForks = DSViewBuilder.buildStackView(arrangedSubviews: [VStackStars, VStackForks], axis: .horizontal, distribution: .fillEqually, alignment: .center, spacing: 1, backgroundColor: .secondaryLabel)
    
    lazy var arrayViews: [UIView] = [containerView, repoTitle, repoDescription, createAtLabel, createAt, HStackDates, updateAtLabel, updateAt, HStackStarsForks, starImageView, starLabel, starCountLabel, forkImageView, forkLabel, forkCountLabel]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(repo: Repo) {
        showAnimating(alpha: 0)
        repoTitle.text = repo.name
        repoDescription.text = repo.repoDescription
        createAt.text = repo.createdAt.formatDateDMY()
        updateAt.text = repo.updatedAt.formatDateDMY()
        starCountLabel.text = repo.stargazersCount.description
        forkCountLabel.text = repo.forksCount.description
        backgroundColor = .clear
        showAnimating(alpha: 1)
    }
    
    func showAnimating(alpha: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            self.arrayViews.forEach { $0.alpha = alpha }
        }
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        containerView.addSubviews(repoTitle, repoDescription, HStackDates, HStackStarsForks)
        addSubview(containerView)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            repoTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            repoTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            repoTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            repoTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            repoDescription.topAnchor.constraint(equalTo: repoTitle.bottomAnchor, constant: 8),
            repoDescription.leadingAnchor.constraint(equalTo: repoTitle.leadingAnchor),
            repoDescription.trailingAnchor.constraint(equalTo: repoTitle.trailingAnchor),
            
            HStackDates.topAnchor.constraint(equalTo: repoDescription.bottomAnchor, constant: 18),
            HStackDates.leadingAnchor.constraint(equalTo: repoDescription.leadingAnchor),
            HStackDates.trailingAnchor.constraint(equalTo: repoDescription.trailingAnchor),
            
            HStackStarsForks.topAnchor.constraint(equalTo: HStackDates.bottomAnchor, constant: padding),
            HStackStarsForks.leadingAnchor.constraint(equalTo: repoDescription.leadingAnchor),
            HStackStarsForks.trailingAnchor.constraint(equalTo: repoDescription.trailingAnchor),
            HStackStarsForks.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
        ])
    }
}
