//
//  MovieDetailsViewControllerMock.swift
//  MovieDatabaseApiUnitTests
//
//  Created by Val Bratkevich on 31.03.2022.
//

import Foundation
@testable import MovieDatabaseApi

class MovieDetailsViewControllerMock: MovieDetailsViewInput {
    
    let setSectionsStub = MethodStub<[TableSectionDescriptor], ()>()
    let getSectionsStub = MethodStub<(), [TableSectionDescriptor]>()
    var sections: [TableSectionDescriptor] {
        get { getSectionsStub.call() }
        set { setSectionsStub.call(with: newValue) }
    }
    
    let configureStub = MethodStub<MovieModel, ()>()
    func configure(with movie: MovieModel) {
        configureStub.call(with: movie)
    }
}
