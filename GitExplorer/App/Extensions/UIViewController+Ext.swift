//
//  UIViewController+Ext.swift
//  GitExplorer
//
//  Created by Diggo Silva on 15/03/25.
//

import UIKit

extension UIViewController {
    func presentDSAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
