//
//  UIColor+ToImage.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import UIKit

extension UIColor {
    func toImage(_ size: CGSize = CGSize(width: 1, height: 1), cornerRadius: CGFloat? = nil) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            if let cornerRadius = cornerRadius {
                let mask = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: cornerRadius)
                mask.fill()
            } else {
                rendererContext.fill(CGRect(origin: .zero, size: size))
            }
        }
    }
}
