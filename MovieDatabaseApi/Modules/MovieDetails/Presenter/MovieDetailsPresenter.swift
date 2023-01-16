//
//  MovieDetailsPresenter.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation

final class MovieDetailsPresenter {
    
    private let interactor: MovieDetailsInteractorInput
    private weak var moduleOutput: MovieDetailsModuleOutput!
    private weak var view: MovieDetailsViewInput!
    private let movieDetailsFactory: MovieDetailsFactory
    
    private let movie: MovieModel
    
    init(
        interactor: MovieDetailsInteractorInput,
        movie: MovieModel,
        moduleOutput: MovieDetailsModuleOutput,
        movieDetailsFactory: MovieDetailsFactory
    ) {
        self.interactor = interactor
        self.movie = movie
        self.moduleOutput = moduleOutput
        self.movieDetailsFactory = movieDetailsFactory
    }
    
    func configure(view: MovieDetailsViewInput) {
        self.view = view
    }
}

// MARK: MovieDetailsModuleInput

extension MovieDetailsPresenter: MovieDetailsModuleInput { }

// MARK: MovieDetailsViewOutput

extension MovieDetailsPresenter: MovieDetailsViewOutput {
    func viewDidLoad() {
        
        view.configure(with: movie)
        
        do {
            interactor.loadCast(for: try movie.id.unwrap()) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case let .success(castNames):
                    self.view.sections = self.movieDetailsFactory.movieDetailsDisplayData(
                        movie: self.movie,
                        castList: castNames
                    )
                    
                case let .failure(error):
                    Log.error(error)
                }
            }
        } catch {
            Log.error(error)
        }
    }
}

// MARK: MovieDetailsInteractorOutput

extension MovieDetailsPresenter: MovieDetailsInteractorOutput { }
