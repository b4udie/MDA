//
//  MovieDetailsViewController.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import UIKit

class MovieDetailsViewController: BaseTableViewController {
    
    private var output: MovieDetailsViewOutput!
    private var navigationBarLabel = NavigationBarLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewDidLoad()
        setupUI()
    }
    
    func configure(output: MovieDetailsViewOutput) {
        self.output = output
    }
}

// MARK: Private

private extension MovieDetailsViewController {
    
    func setupUI() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .mda.chineseBlack
        appearance.titleTextAttributes = [.foregroundColor: UIColor.mda.white]
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        navigationBarLabel.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        let rightButtonItem = UIBarButtonItem(customView: navigationBarLabel)
        navigationItem.rightBarButtonItem = rightButtonItem
        
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.backgroundColor = .mda.black
    }
}

// MARK: MovieDetailsViewInput

extension MovieDetailsViewController: MovieDetailsViewInput {
    
    func configure(with movie: MovieModel) {
        title = movie.title
        
        do {
            navigationBarLabel.configure(voteAverage: try movie.voteAverage.unwrap())
        } catch {
            Log.error(error)
        }
    }
}
