//
//  DSItemInfoViewOne.swift
//  GitExplorer
//
//  Created by Diggo Silva on 16/03/25.
//

import UIKit

protocol DSItemInfoViewOneDelegate: AnyObject {
    func didTapRepoButton()
}

class DSItemInfoViewOne: DSItemInfoViewBase {
    
    weak var delegate: DSItemInfoViewOneDelegate?
    
    init() {
        super.init(leftIcon: SFSymbols.repo, leftTitle: InfoItemType.repos.rawValue, leftCount: "",
                   rightIcon: SFSymbols.gist, rightTitle: InfoItemType.gists.rawValue, rightCount: "",
                   buttonTitle: "Repositórios", buttonColor: .systemIndigo, buttonImage: SFSymbols.repo, buttonAction: #selector(didTapRepoButton))
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    @objc private func didTapRepoButton() {
        delegate?.didTapRepoButton()
    }
}
