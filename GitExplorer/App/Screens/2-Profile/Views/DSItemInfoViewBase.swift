//
//  DSItemInfoView.swift
//  GitExplorer
//
//  Created by Diggo Silva on 16/03/25.
//

import UIKit

class DSItemInfoViewBase: UIView {
   
    //MARK: Propriedades configuráveis
    private let leftIcon: UIImage?
    private let leftTitle: String
    private let leftCount: String
    private let rightIcon: UIImage?
    private let rightTitle: String
    private let rightCount: String
    private let buttonTitle: String
    private let buttonColor: UIColor
    private let buttonImage: UIImage?
    private let buttonAction: Selector
    private let additionalLabelText: String? // Para o caso do createdAtLabel opcional
    
    //MARK: Componentes UI
    lazy var symbolImageViewOne = DSViewBuilder.buildIconImageView(image: leftIcon)
    lazy var titleLabelOne = DSViewBuilder.buildLabel(text: leftTitle, font: .preferredFont(forTextStyle: .headline))
    lazy var countLabelOne = DSViewBuilder.buildLabel(text: leftCount, textColor: .label, textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    
    lazy var HStackViewOne = DSViewBuilder.buildStackView(arrangedSubviews: [symbolImageViewOne, titleLabelOne])
    lazy var VStackViewOne = DSViewBuilder.buildStackView(arrangedSubviews: [HStackViewOne, countLabelOne], axis: .vertical)
    
    lazy var symbolImageViewTwo = DSViewBuilder.buildIconImageView(image: rightIcon)
    lazy var titleLabelTwo = DSViewBuilder.buildLabel(text: rightTitle, font: .preferredFont(forTextStyle: .headline))
    lazy var countLabelTwo = DSViewBuilder.buildLabel(text: rightCount, textColor: .label, textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    
    lazy var HStackViewTwo = DSViewBuilder.buildStackView(arrangedSubviews: [symbolImageViewTwo, titleLabelTwo])
    lazy var VStackViewTwo = DSViewBuilder.buildStackView(arrangedSubviews: [HStackViewTwo, countLabelTwo], axis: .vertical)
    
    lazy var HStackViewFINAL = DSViewBuilder.buildStackView(arrangedSubviews: [VStackViewOne, VStackViewTwo], distribution: .fillEqually)
    
    lazy var actionButton = DSViewBuilder.buildButton(title: buttonTitle, color: buttonColor, image: buttonImage, selector: buttonAction)
    
    lazy var additionalLabel: UILabel? = {
        guard let text = additionalLabelText else { return nil }
        return DSViewBuilder.buildLabel(text: text, textColor: .secondaryLabel, textAlignment: .center, font: .preferredFont(forTextStyle: .headline))
    }()
    
    //MARK: Inicializador customizado
    init(leftIcon: UIImage?, leftTitle: String, leftCount: String,
         rightIcon: UIImage?, rightTitle: String, rightCount: String,
         buttonTitle: String, buttonColor: UIColor, buttonImage: UIImage?, buttonAction: Selector,
         additionalLabelText: String? = nil) {
        self.leftIcon = leftIcon
        self.leftTitle = leftTitle
        self.leftCount = leftCount
        self.rightIcon = rightIcon
        self.rightTitle = rightTitle
        self.rightCount = rightCount
        self.buttonTitle = buttonTitle
        self.buttonColor = buttonColor
        self.buttonImage = buttonImage
        self.buttonAction = buttonAction
        self.additionalLabelText = additionalLabelText
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .secondarySystemBackground
        if let additionalLabel = additionalLabel {
            addSubviews(HStackViewFINAL, actionButton, additionalLabel)
        } else {
            addSubviews(HStackViewFINAL, actionButton)
        }
    }
    
    private func setConstraints() {
        let padding: CGFloat = 15
        let sizeSymbols: CGFloat = 20
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        
        var constraints = [
            HStackViewFINAL.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            HStackViewFINAL.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            HStackViewFINAL.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            symbolImageViewOne.widthAnchor.constraint(equalToConstant: sizeSymbols),
            symbolImageViewOne.heightAnchor.constraint(equalTo: symbolImageViewOne.widthAnchor),
            
            symbolImageViewTwo.widthAnchor.constraint(equalToConstant: sizeSymbols),
            symbolImageViewTwo.heightAnchor.constraint(equalTo: symbolImageViewTwo.widthAnchor),
            
            actionButton.leadingAnchor.constraint(equalTo: HStackViewFINAL.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: HStackViewFINAL.trailingAnchor),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ]
        
        if let additionalLabel = additionalLabel {
            constraints.append(contentsOf: [
                additionalLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: padding),
                additionalLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                additionalLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
        
        NSLayoutConstraint.activate(constraints)
    }
}
