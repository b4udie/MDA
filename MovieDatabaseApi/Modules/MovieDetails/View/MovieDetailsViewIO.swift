//
//  MovieDetailsViewIO.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation

protocol MovieDetailsViewInput: AnyObject {
    
    var sections: [TableSectionDescriptor] { get set }
    
    func configure(with movie: MovieModel)
}

protocol MovieDetailsViewOutput: AnyObject {
    
    func viewDidLoad()
}
