//
//  DSHeaderView.swift
//  GitExplorer
//
//  Created by Diggo Silva on 16/03/25.
//


class DSHeaderView: UIView {
    
    lazy var avatarImageView = DSViewBuilder.buildImageView(image: Images.avatar)
    lazy var loginLabel = DSViewBuilder.buildLabel(text: "Jobs-iOS")
    lazy var nameLabel = DSViewBuilder.buildLabel(text: "Steve Jobs", textColor: .secondaryLabel, font: .preferredFont(forTextStyle: .headline))
    lazy var locationImage = DSViewBuilder.buildImageView(image: SFSymbols.location?.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal))
    lazy var locationLabel = DSViewBuilder.buildLabel(text: "San Francisco, CA", textColor: .secondaryLabel, font: .preferredFont(forTextStyle: .headline))
    lazy var bioLabel = DSViewBuilder.buildLabel(text: "Co-founder, Chairman, and CEO of Apple Inc and Next Step Media. Co-founder, Chairman, and CEO of Apple Inc and Next Step Media.", textColor: .secondaryLabel, font: .preferredFont(forTextStyle: .body), numberOfLines: 3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
        configAvatarImageView()
    }
    
    func configAvatarImageView() {
        let width: CGFloat = 100
        avatarImageView.backgroundColor = .systemGray
        avatarImageView.layer.cornerRadius = width / 2
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true
    }
    
    private func setHierarchy() {
        addSubviews(avatarImageView, loginLabel, nameLabel, locationImage, locationLabel, bioLabel)
    }
    
    private func setConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            loginLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            loginLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            nameLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: loginLabel.trailingAnchor),
            
            locationImage.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImage.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            locationImage.widthAnchor.constraint(equalToConstant: 20),
            locationImage.heightAnchor.constraint(equalTo: locationImage.widthAnchor),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 4),
            locationLabel.trailingAnchor.constraint(equalTo: loginLabel.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalTo: locationImage.heightAnchor),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 15),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            bioLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -padding)
        ])
    }
}