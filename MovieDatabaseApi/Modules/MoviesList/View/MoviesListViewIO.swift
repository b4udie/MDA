//
//  MoviesListViewIO.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation

protocol MoviesListViewInput: AnyObject {
    
    var sections: [TableSectionDescriptor] { get set }
}

protocol MoviesListViewOutput: AnyObject {
    
    func viewDidLoad()
    func viewWillDisappear()
    func updateData()
    func didChangeSearchBarText(_ text: String)
    func searchBarCancelButtonClicked()
}
