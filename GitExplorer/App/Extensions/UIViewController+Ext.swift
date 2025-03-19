//
//  UIViewController+Ext.swift
//  GitExplorer
//
//  Created by Diggo Silva on 15/03/25.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentDSAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func presentSafari(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .label
        present(safariVC, animated: true)
    }
}
