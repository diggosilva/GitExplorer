//
//  DSViewBuilder.swift
//  GitExplorer
//
//  Created by Diggo Silva on 15/03/25.
//

import UIKit

enum DSViewBuilder {
    static func buildImageView(image: UIImage? = Images.logo) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        return imageView
    }
    
    static func buildLabel(text: String, textAlignment: NSTextAlignment = .center, font: UIFont = .preferredFont(forTextStyle: .extraLargeTitle)) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = textAlignment
        label.font = font
        return label
    }
    
    static func buildTextField(placeholder: String = "Digite o nome do usuário...", selector: Selector) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.cornerRadius = 8
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.clearButtonMode = .whileEditing
        textField.autocorrectionType = .no
        textField.returnKeyType = .go
        textField.font = .systemFont(ofSize: 20)
        
        textField.addTarget(self, action: selector, for: .editingChanged)
        return textField
    }
    
    static func buildButton(title: String, color: UIColor, image: UIImage?, isEnabled: Bool = true, selector: Selector) -> UIButton {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = title
        configuration.baseBackgroundColor = color
        configuration.baseForegroundColor = color
        configuration.image = image
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = isEnabled
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
}
