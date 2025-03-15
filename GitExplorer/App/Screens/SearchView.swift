class SearchView: UIView {
    
    lazy var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = Images.logo
        return iv
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Git Explorer"
        lbl.textAlignment = .center
        lbl.font = .preferredFont(forTextStyle: .extraLargeTitle)
        return lbl
    }()
    
    lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Digite o nome do usuário..."
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.systemGray3.cgColor
        tf.layer.cornerRadius = 8
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height)) // 10 é o padding
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        tf.clearButtonMode = .whileEditing
        tf.autocorrectionType = .no
        tf.font = .systemFont(ofSize: 20)
        return tf
    }()
    
    lazy var searchButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "Buscar Usuário"
        configuration.baseBackgroundColor = .systemGreen
        configuration.baseForegroundColor = .systemGreen
        configuration.image = SFSymbols.search
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    @objc private func searchButtonTapped() {
        print("Clicou no botão de buscar")
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

#Preview {
    SearchViewController()
}

