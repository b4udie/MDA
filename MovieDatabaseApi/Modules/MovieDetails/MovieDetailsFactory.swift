//
//  MovieDetailsFactory.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 31.03.2022.
//

import Foundation

final class MovieDetailsFactory {
    private let imageHelper: IImageHelper
    
    init(imageHelper: IImageHelper) {
        self.imageHelper = imageHelper
    }
    
    func movieDetailsDisplayData(
        movie: MovieModel,
        castList: [String]
    ) -> [TableSectionDescriptor] {
        
        return [
            TableSectionDescriptor(
                cellsDescriptors: [
                    PosterCellDescriptor(
                        viewModel: .init(
                            posterImageURL: imageHelper.createImageURL(with: movie.posterPath, quality: .backdrop(.original))
                        )
                    )
                ]
            ),
            TableSectionDescriptor(
                headerDescriptor: SectionHeaderDescriptior(
                    viewModel: .init(title: "Overview")
                ),
                cellsDescriptors: [
                    DescriptionTableCellDescriptor(viewModel: .init(description: movie.overview))
                ]
            ),
            TableSectionDescriptor(
                headerDescriptor: SectionHeaderDescriptior(
                    viewModel: .init(title: "Cast")
                ),
                cellsDescriptors: [
                    DescriptionTableCellDescriptor(viewModel: .init(description: castList.joined(separator: ", ")))
                ]
            )
        ]
    }
}
