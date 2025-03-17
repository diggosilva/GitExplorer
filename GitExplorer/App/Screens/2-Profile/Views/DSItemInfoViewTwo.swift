//
//  DSItemInfoViewTwo.swift
//  GitExplorer
//
//  Created by Diggo Silva on 16/03/25.
//


class DSItemInfoViewTwo: UIView {
    
    lazy var symbolImageViewOne = DSViewBuilder.buildIconImageView(image: SFSymbols.followers)
    lazy var titleLabelOne = DSViewBuilder.buildLabel(text: InfoItemType.followers.rawValue, font: .preferredFont(forTextStyle: .headline))
    lazy var countLabelOne = DSViewBuilder.buildLabel(text: "10", textColor: .label, textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    
    lazy var HStackViewOne = DSViewBuilder.buildStackView(arrangedSubviews: [symbolImageViewOne, titleLabelOne])
    lazy var VStackViewOne = DSViewBuilder.buildStackView(arrangedSubviews: [HStackViewOne, countLabelOne], axis: .vertical)
    
    
    lazy var symbolImageViewTwo = DSViewBuilder.buildIconImageView(image: SFSymbols.following)
    lazy var titleLabelTwo = DSViewBuilder.buildLabel(text: InfoItemType.following.rawValue, font: .preferredFont(forTextStyle: .headline))
    lazy var countLabelTwo = DSViewBuilder.buildLabel(text: "20", textColor: .label, textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    
    lazy var HStackViewTwo = DSViewBuilder.buildStackView(arrangedSubviews: [symbolImageViewTwo, titleLabelTwo])
    lazy var VStackViewTwo = DSViewBuilder.buildStackView(arrangedSubviews: [HStackViewTwo, countLabelTwo], axis: .vertical)
    
    lazy var HStackViewFINAL = DSViewBuilder.buildStackView(arrangedSubviews: [VStackViewOne, VStackViewTwo], distribution: .fillEqually)
    
    lazy var actionButton = DSViewBuilder.buildButton(title: "Perfil GitHub", color: .systemTeal, image: SFSymbols.ghProfile, selector: #selector(didTapProfileButton))
    
    lazy var createAtLabel = DSViewBuilder.buildLabel(text: "GitHub desde 01/01/2021", textColor: .secondaryLabel, textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    @objc private func didTapProfileButton() {
        print("DEBUG: Mostrar perfil do GitHub")
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .secondarySystemBackground
        addSubviews(HStackViewFINAL, actionButton, createAtLabel)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 15
        let sizeSymbols: CGFloat = 20
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            HStackViewFINAL.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            HStackViewFINAL.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            HStackViewFINAL.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            symbolImageViewOne.widthAnchor.constraint(equalToConstant: sizeSymbols),
            symbolImageViewOne.heightAnchor.constraint(equalTo: symbolImageViewOne.widthAnchor),
            
            symbolImageViewTwo.widthAnchor.constraint(equalToConstant: sizeSymbols),
            symbolImageViewTwo.heightAnchor.constraint(equalTo: symbolImageViewTwo.widthAnchor),
            
            actionButton.leadingAnchor.constraint(equalTo: HStackViewFINAL.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: HStackViewFINAL.trailingAnchor),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            
            createAtLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: padding),
            createAtLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            createAtLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}