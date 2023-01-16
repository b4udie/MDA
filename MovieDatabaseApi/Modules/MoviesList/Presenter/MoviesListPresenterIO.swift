//
//  MoviesListPresenterIO.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation

protocol MoviesListModuleOutput: AnyObject {
    
    func module(_ input: MoviesListModuleInput, wantsToOpenDetailsWith movie: MovieModel)
}

protocol MoviesListModuleInput: AnyObject { }
