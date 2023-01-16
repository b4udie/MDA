//
//  UITableView+ReusableSupport.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 31.03.2022.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) {
        register(UINib(nibName: T.reuseIdentifier, bundle: Bundle.main),
                 forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(headerType: T.Type) {
        register(UINib(nibName: T.reuseIdentifier, bundle: Bundle.main),
                 forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
    
    func dequeueReusableHeader<T: UITableViewHeaderFooterView>(headerType: T.Type = T.self) -> T {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: headerType.reuseIdentifier) as? T else {
            fatalError(
                "Failed to dequeue a header with identifier \(headerType.reuseIdentifier) matching type \(headerType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the headerType beforehand"
            )
        }
        return cell
    }
}
