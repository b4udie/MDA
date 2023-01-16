//
//  ITableHeader.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 31.03.2022.
//

import UIKit

protocol ITableHeaderDescriptor: AnyObject {
    
    var height: CGFloat { get }

    func register(for tableView: UITableView)
    func dequeue(for tableView: UITableView, in section: Int) -> UIView?
}
