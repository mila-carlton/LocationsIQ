//
//  SearchViewModel.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 25.03.24.
//

import Foundation

final class SearchViewModel {
    var searchResults: SearchModel = []
    var query = ""
    private let webService = WebService.shared
    
    func getSearchResults(query: String, completion: @escaping (() -> Void)) {
        webService.fetchSearch(query: query) { [weak self] results in
            guard let self = self else { return }
            if let searchResult = results {
                self.searchResults.removeAll()
                self.searchResults = searchResult
                completion()
            } else {
                print("Search error")
            }
        }
    }
}
