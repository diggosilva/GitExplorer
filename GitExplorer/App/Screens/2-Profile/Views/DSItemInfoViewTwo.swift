//
//  DSItemInfoViewTwo.swift
//  GitExplorer
//
//  Created by Diggo Silva on 16/03/25.
//

import UIKit

protocol DSItemInfoViewTwoDelegate: AnyObject {
    func didTapProfileButton()
}

class DSItemInfoViewTwo: DSItemInfoViewBase {
    
    weak var delegate: DSItemInfoViewTwoDelegate?
    
    init() {
        super.init(leftIcon: SFSymbols.followers, leftTitle: InfoItemType.followers.rawValue, leftCount: "",
                   rightIcon: SFSymbols.following, rightTitle: InfoItemType.following.rawValue, rightCount: "",
                   buttonTitle: "Perfil GitHub", buttonColor: .systemTeal, buttonImage: SFSymbols.ghProfile, buttonAction: #selector(didTapProfileButton))
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    @objc private func didTapProfileButton() {
        delegate?.didTapProfileButton()
    }
}
