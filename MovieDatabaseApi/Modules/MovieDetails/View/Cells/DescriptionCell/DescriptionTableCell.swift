//
//  DescriptionTableCell.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 31.03.2022.
//

import UIKit

struct DescriptionViewModel {
    let description: String?
}

final class DescriptionTableCellDescriptor {

    private let viewModel: DescriptionViewModel
    
    init(
        viewModel: DescriptionViewModel
    ) {
        self.viewModel = viewModel
    }
}

extension DescriptionTableCellDescriptor: ITableCellDescriptor {
    var height: CGFloat {
        viewModel.description?.height(
            withConstrainedWidth: UIScreen.main.bounds.width - 40,
            font: .systemFont(ofSize: 14)
        ) ?? 0
    }
    
    func register(for tableView: UITableView) {
        tableView.register(cellType: DescriptionTableViewCell.self)
    }
    
    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DescriptionTableViewCell.self)
        cell.configure(with: viewModel)
        cell.apply()
        return cell
    }
}
