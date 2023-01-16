//
//  PosterCellViewModel.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 31.03.2022.
//

import UIKit

struct PosterCellViewModel {
    let posterImageURL: URL?
}

final class PosterCellDescriptor {

    private let viewModel: PosterCellViewModel

    init(
        viewModel: PosterCellViewModel
    ) {
        self.viewModel = viewModel
    }
}

extension PosterCellDescriptor: ITableCellDescriptor {
    var height: CGFloat {
        550.0
    }
    
    func register(for tableView: UITableView) {
        tableView.register(cellType: PosterCell.self)
    }
    
    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PosterCell.self)
        cell.configure(with: viewModel)
        return cell
    }
}
