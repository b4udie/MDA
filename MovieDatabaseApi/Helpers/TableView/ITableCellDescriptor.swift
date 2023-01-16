//
//  ITableCellDescriptor.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import UIKit

protocol ITableCellDescriptor {
    
    var height: CGFloat { get }
    
    func register(for tableView: UITableView)
    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

extension ITableCellDescriptor {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
}
