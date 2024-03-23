//
//  SearchViewController.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 22.03.24.
//

import UIKit

final class SearchViewController: UIViewController,UISearchBarDelegate, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchVC()
        view.backgroundColor = .lightGray
       
    }
    
    override func viewWillLayoutSubviews() {
        searchController.isActive = true
        searchController.searchBar.becomeFirstResponder()
    }
    
    func setupSearchVC() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    
    }

}
