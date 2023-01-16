//
//  UISearchBar+Coustomization.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import UIKit

extension UISearchBar {

    private var textField: UITextField? {
        return value(forKey: "searchField") as? UITextField
    }

    var textColor: UIColor? {
        get {
            return textField?.textColor
        }
        set {
            textField?.textColor = newValue
        }
    }

    var searchImageColor: UIColor? {
        get {
            guard let imageView = textField?.leftView as? UIImageView else { return nil }
            return imageView.tintColor
        }
        set {
            guard let imageView = textField?.leftView as? UIImageView else { return }
            imageView.tintColor = newValue
            imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        }
    }

    func setPlaceholderTextColor(_ color: UIColor) {
        guard let textField = self.textField else { return }
        textField.attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                             attributes: [.foregroundColor: color])
    }

    func setTextFieldColor(_ color: UIColor) {
        guard let textField = self.textField else { return }
        setNeedsLayout()
        layoutIfNeeded()
        let defaultTextFieldCornerRadius: CGFloat = 11.0
        let searchFieldBackgroundImage = color.toImage(CGSize(width: textField.bounds.width,
                                                              height: textField.bounds.height),
                                                       cornerRadius: defaultTextFieldCornerRadius)
        setSearchFieldBackgroundImage(searchFieldBackgroundImage, for: .normal)
        let defaultTextHorizontalOffset: CGFloat = 8.0
        searchTextPositionAdjustment = UIOffset(horizontal: defaultTextHorizontalOffset,
                                                vertical: 0.0)
    }
}
