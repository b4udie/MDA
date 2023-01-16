//
//  MoviesListPresenter.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import Foundation

final class MoviesListPresenter {
    
    private let interactor: MoviesListInteractorInput
    private weak var moduleOutput: MoviesListModuleOutput!
    private weak var view: MoviesListViewInput!
    
    private let moviesListDataFactory: MoviesListDataFactory
    private var genres: [GenresModel.Genre] = []
    private var moviesListModel: [MovieModel] = []
    private var searchMoviesListModel: [MovieModel] = []
    private var isPaginationEnabled = false
    private var isSearchEnabled = false
    private var searchText = ""
    
    init(
        interactor: MoviesListInteractorInput,
        moduleOutput: MoviesListModuleOutput,
        moviesListDataFactory: MoviesListDataFactory
    ) {
        self.interactor = interactor
        self.moduleOutput = moduleOutput
        self.moviesListDataFactory = moviesListDataFactory
    }
    
    func configure(view: MoviesListViewInput) {
        self.view = view
    }
}

// MARK: Private

private extension MoviesListPresenter {
    
    func loadData() {
        let group = DispatchGroup()
        
        group.enter()
        interactor.loadGenres { [weak self] result in
            guard let self = self else { return }
            
            if case let .success(genres) = result,
               let genres = genres {
                
                self.genres = genres
                group.leave()
            }
        }
        
        group.enter()
        interactor.loadPopularList { [weak self] result in
            guard let self = self else { return }
            
            if case let .success(moviesListModel) = result,
               let moviesList = moviesListModel {
                
                self.moviesListModel = moviesList
                group.leave()
            }
            
            self.isPaginationEnabled = true
        }
        
        group.notify(queue: .main) {
            self.view.sections = self.moviesListDataFactory.moviesListDisplayData(
                genres: self.genres,
                moviesList: self.moviesListModel,
                didTapOnCell: self.didSelect
            )
        }
    }
    
    func loadPaginationData() {
        isPaginationEnabled = false
        
        interactor.loadPopularList { [weak self] result in
            guard let self = self else { return }
            
            if case let .success(moviesListModel) = result,
               let moviesList = moviesListModel {
                
                self.moviesListModel.append(contentsOf: moviesList)
                
                DispatchQueue.main.async {
                    self.view.sections = self.moviesListDataFactory.moviesListDisplayData(
                        genres: self.genres,
                        moviesList: self.moviesListModel,
                        didTapOnCell: self.didSelect
                    )
                }
            }
            
            self.isPaginationEnabled = true
        }
    }
    
    func loadSearchPaginationData() {
        isPaginationEnabled = false
        
        interactor.loadMovies(by: searchText) { [weak self] result in
            guard let self = self else { return }
            
            if case let .success(moviesListModel) = result,
               let moviesList = moviesListModel {
                
                self.searchMoviesListModel.append(contentsOf: moviesList)
                
                DispatchQueue.main.async {
                    self.view.sections = self.moviesListDataFactory.moviesListDisplayData(
                        genres: self.genres,
                        moviesList: self.searchMoviesListModel,
                        didTapOnCell: self.didSelect
                    )
                }
            }
            
            self.isPaginationEnabled = true
        }
    }
    
    func clearSearchResults() {
        DispatchQueue.main.async {
            self.view.sections = self.moviesListDataFactory.moviesListDisplayData(
                genres: self.genres,
                moviesList: self.moviesListModel,
                didTapOnCell: self.didSelect
            )
        }
        
        isSearchEnabled = false
    }
    
    func didSelect(movie: MovieModel) {
        moduleOutput.module(self, wantsToOpenDetailsWith: movie)
    }
}

// MARK: MoviesListModuleInput

extension MoviesListPresenter: MoviesListModuleInput { }

// MARK: MoviesListViewOutput

extension MoviesListPresenter: MoviesListViewOutput {
    
    func viewDidLoad() {
        loadData()
    }
    
    func viewWillDisappear() {
        isSearchEnabled = false
        isPaginationEnabled = true
    }
    
    func updateData() {
        guard isPaginationEnabled else {
            return
        }

        isSearchEnabled
            ? loadSearchPaginationData()
            : loadPaginationData()
    }
    
    func didChangeSearchBarText(_ text: String) {
        Throttler.throttle(delay: .milliseconds(500)) { [weak self] in
            guard let self = self else { return }
            
            guard !text.isEmpty else {
                return self.clearSearchResults()
            }
                        
            self.searchText = text
            self.isSearchEnabled = true
            
            self.interactor.loadMovies(by: text) { [weak self] result in
                guard let self = self else { return }
                
                if case let .success(moviesListModel) = result,
                   let moviesList = moviesListModel {
                    
                    self.searchMoviesListModel = moviesList

                    DispatchQueue.main.async {
                        self.view.sections = self.moviesListDataFactory.moviesListDisplayData(
                            genres: self.genres,
                            moviesList: self.searchMoviesListModel,
                            didTapOnCell: self.didSelect
                        )
                    }
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked() {
        clearSearchResults()
    }
}

// MARK: MoviesListInteractorOutput

extension MoviesListPresenter: MoviesListInteractorOutput { }
