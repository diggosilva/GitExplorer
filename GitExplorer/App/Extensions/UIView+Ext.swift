//
//  UIView+Ext.swift
//  GitExplorer
//
//  Created by Diggo Silva on 13/03/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
