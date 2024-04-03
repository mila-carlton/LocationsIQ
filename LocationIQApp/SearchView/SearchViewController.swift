//
//  SearchViewController.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 22.03.24.
//

import UIKit

final class SearchViewController: UIViewController,UISearchBarDelegate, UISearchResultsUpdating {
    
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
        tableView.rowHeight = 50
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        return tableView
    }()
    
    
    let searchController = UISearchController(searchResultsController: nil)
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchVC()
        setupLayouts()
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
        guard let query = searchController.searchBar.text, !query.isEmpty else { viewModel.searchResults.removeAll()
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
            return }
        viewModel.getSearchResults(query: query) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
        
    }
    
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: view.topAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as! ListTableViewCell
        cell.configure(searchItem: viewModel.searchResults[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = viewModel.searchResults[indexPath.row]
        let detailsViewModel = DetailsViewModel(location: selectedCategory)
        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    
}
