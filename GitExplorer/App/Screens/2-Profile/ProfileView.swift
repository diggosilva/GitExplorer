class ProfileView: UIView {
    
    lazy var headerView = DSHeaderView()
    lazy var infoViewOne = DSItemInfoViewOne()
    lazy var infoViewTwo = DSItemInfoViewTwo()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(user: User) {
        headerView.loginLabel.text = user.login
        headerView.locationLabel.text = user.location
        headerView.bioLabel.text = user.bio
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .systemBackground
        addSubviews(headerView, infoViewOne, infoViewTwo)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 20
        let heightInfoView: CGFloat = 150
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            infoViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            infoViewOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            infoViewOne.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            infoViewOne.heightAnchor.constraint(equalToConstant: heightInfoView),
            
            infoViewTwo.topAnchor.constraint(equalTo: infoViewOne.bottomAnchor, constant: padding),
            infoViewTwo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            infoViewTwo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            infoViewTwo.heightAnchor.constraint(equalToConstant: heightInfoView),
        ])
    }
}