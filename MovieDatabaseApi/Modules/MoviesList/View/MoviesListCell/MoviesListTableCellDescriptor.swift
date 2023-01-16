//
//  MoviesListTableCell.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import UIKit

struct MoviesListViewModel {
    let title: String?
    let posterImageURL: URL?
    let rating: String
    let ratingProgressValue: Float
    let genres: String
}

final class MoviesListTableCellDescriptor {

    private let viewModel: MoviesListViewModel
    private let moviesList: [MovieModel]
    private let onTapClosure: ((MovieModel) -> Void)?

    init(
        viewModel: MoviesListViewModel,
        moviesList: [MovieModel],
        onTapClosure: @escaping (MovieModel) -> Void
    ) {
        self.viewModel = viewModel
        self.moviesList = moviesList
        self.onTapClosure = onTapClosure
    }
}

extension MoviesListTableCellDescriptor: ITableCellDescriptor {
    var height: CGFloat { 100.0 }
    
    func register(for tableView: UITableView) {
        tableView.register(cellType: MoviesListTableViewCell.self)
    }
    
    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MoviesListTableViewCell.self)
        cell.apply()
        cell.configure(with: viewModel, isFirstCell: indexPath.row == 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTapClosure?(moviesList[indexPath.row])
    }
}
