//
//  MoviesListViewController.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import UIKit

final class MoviesListViewController: BaseTableViewController {
    
    private var output: MoviesListViewOutput?
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        output?.viewWillDisappear()
    }
    
    func configure(output: MoviesListViewOutput) {
        self.output = output
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let pos = scrollView.contentOffset.y
         if pos > tableView.contentSize.height - 50 - scrollView.frame.size.height {
             output?.updateData()
         }
     }
}

// MARK: Private

private extension MoviesListViewController {
    
    func setupUI() {
        view.backgroundColor = .mda.black

        tableView.backgroundColor = .mda.black
        tableView.showsVerticalScrollIndicator = false
        
        searchBar.textColor = .mda.white
        searchBar.searchImageColor = .mda.darkGray
        searchBar.setPlaceholderTextColor(.mda.darkGray)
        searchBar.setTextFieldColor(.mda.eerieBlack)
        searchBar.delegate = self
        searchBar.tintColor = .mda.darkGray
        
        let micImage = UIImage(systemName: "mic.fill")
        searchBar.setImage(micImage, for: .bookmark, state: .normal)
        searchBar.showsBookmarkButton = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .mda.chineseBlack
        appearance.titleTextAttributes = [.foregroundColor: UIColor.mda.white]
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor.mda.orange
    }
}

// MARK: MoviesListViewInput

extension MoviesListViewController: MoviesListViewInput {
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: UISearchBarDelegate

extension MoviesListViewController: UISearchBarDelegate {
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchBar.text ?? ""
        output?.didChangeSearchBarText(text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        output?.searchBarCancelButtonClicked()
    }
}
