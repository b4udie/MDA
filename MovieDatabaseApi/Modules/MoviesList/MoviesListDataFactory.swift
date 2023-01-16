//
//  MoviesListDataFactory.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation

final class MoviesListDataFactory {
    
    private let imageHelper: IImageHelper
    
    init(imageHelper: IImageHelper) {
        self.imageHelper = imageHelper
    }
        
    func moviesListDisplayData(
        genres: [GenresModel.Genre],
        moviesList: [MovieModel],
        didTapOnCell: @escaping ((MovieModel) -> Void)
    ) -> [TableSectionDescriptor] {
        
        let cells = moviesList.compactMap { movie -> MoviesListViewModel? in
            guard movie.id != nil else { return nil }
            
            var movieGenres: [String?] = []
            
            genres.forEach { genre in
                if movie.genreIds?.contains(genre.id ?? -1) == true {
                    movieGenres.append(genre.name)
                }
            }
            
            return MoviesListViewModel(
                title: movie.title,
                posterImageURL: imageHelper.createImageURL(with: movie.posterPath, quality: .poster(.w342)),
                rating: String(movie.voteAverage ?? 0),
                ratingProgressValue: Float((movie.voteAverage ?? 0) / 10),
                genres: movieGenres.compactMap { $0 }.joined(separator: ", ").uppercased()
            )
        }
        
        return [
            TableSectionDescriptor(
                cellsDescriptors: cells.map { MoviesListTableCellDescriptor(viewModel: $0, moviesList: moviesList, onTapClosure: didTapOnCell) }
            )
        ]
    }
}
