class RepositoriesCell: UITableViewCell {
    
    static let identifier = "RepositoriesCell"
    
    lazy var repoTitle = DSViewBuilder.buildLabel(text: "TESTE", textAlignment: .center, font: .boldSystemFont(ofSize: 24))
    lazy var repoDescription = DSViewBuilder.buildLabel(text: "Breve descrição do repositório. Breve descrição do repositório. Breve descrição do repositório. Breve descrição do repositório. Breve descrição do repositório.", textAlignment: .init(rawValue: 0)!, font: .init(name: "HelveticaNeue-Light", size: 17)!, numberOfLines: 2)
    
    lazy var createAtLabel = DSViewBuilder.buildLabel(text: "Criado em", textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    lazy var createAt = DSViewBuilder.buildLabel(text: "01/02/2003", textColor: .secondaryLabel, textAlignment: .center, font: .preferredFont(forTextStyle: .subheadline))
    lazy var VStackDate = DSViewBuilder.buildStackView(arrangedSubviews: [createAtLabel, createAt], axis: .vertical, distribution: .fillEqually, alignment: .center, backgroundColor: .systemBackground)
    
    lazy var updateAtLabel = DSViewBuilder.buildLabel(text: "Atualizado em", textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    lazy var updateAt = DSViewBuilder.buildLabel(text: "04/05/2006", textColor: .secondaryLabel, textAlignment: .center, font: .preferredFont(forTextStyle: .subheadline))
    lazy var VStackUpdate = DSViewBuilder.buildStackView(arrangedSubviews: [updateAtLabel, updateAt], axis: .vertical, distribution: .fillEqually, alignment: .center, backgroundColor: .systemBackground)
    
    lazy var HStackDates = DSViewBuilder.buildStackView(arrangedSubviews: [VStackDate, VStackUpdate], axis: .horizontal, distribution: .fillEqually, alignment: .center, spacing: 1, backgroundColor: .secondaryLabel)
    
    
    lazy var starImageView = DSViewBuilder.buildIconImageView(image: SFSymbols.star)
    lazy var starCountLabel = DSViewBuilder.buildLabel(text: "24", textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    lazy var VStackStars = DSViewBuilder.buildStackView(arrangedSubviews: [starImageView, starCountLabel], axis: .vertical, distribution: .fillEqually, alignment: .center, backgroundColor: .systemBackground)
    
    lazy var forkImageView = DSViewBuilder.buildIconImageView(image: SFSymbols.fork)
    lazy var forkCountLabel = DSViewBuilder.buildLabel(text: "35", textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    lazy var VStackForks = DSViewBuilder.buildStackView(arrangedSubviews: [forkImageView, forkCountLabel], axis: .vertical, distribution: .fillEqually, alignment: .center, backgroundColor: .systemBackground)
    
    lazy var HStackStarsForks = DSViewBuilder.buildStackView(arrangedSubviews: [VStackStars, VStackForks], axis: .horizontal, distribution: .fillEqually, alignment: .center, spacing: 1, backgroundColor: .secondaryLabel)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(repo: Repo) {
        repoTitle.text = repo.name
        repoDescription.text = repo.description
        createAt.text = "\(repo.createdAt)"
        updateAt.text = "\(repo.updatedAt)"
        starCountLabel.text = repo.stargazersCount.description
        forkCountLabel.text = repo.forksCount.description
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        addSubviews(repoTitle, repoDescription, HStackDates, HStackStarsForks)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            repoTitle.topAnchor.constraint(equalTo: topAnchor),
            repoTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            repoTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            repoTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            repoDescription.topAnchor.constraint(equalTo: repoTitle.bottomAnchor, constant: 8),
            repoDescription.leadingAnchor.constraint(equalTo: repoTitle.leadingAnchor),
            repoDescription.trailingAnchor.constraint(equalTo: repoTitle.trailingAnchor),
            
            HStackDates.topAnchor.constraint(equalTo: repoDescription.bottomAnchor, constant: 8),
            HStackDates.leadingAnchor.constraint(equalTo: repoDescription.leadingAnchor),
            HStackDates.trailingAnchor.constraint(equalTo: repoDescription.trailingAnchor),
            
            HStackStarsForks.topAnchor.constraint(equalTo: HStackDates.bottomAnchor, constant: padding),
            HStackStarsForks.leadingAnchor.constraint(equalTo: repoDescription.leadingAnchor),
            HStackStarsForks.trailingAnchor.constraint(equalTo: repoDescription.trailingAnchor),
            HStackStarsForks.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}


