//
//  ListViewModel.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 23.03.24.
//

import Foundation


final class ListViewModel {
    
    private var category: CategoriesEnum = .all
    
    init(category: CategoriesEnum) {
        self.category = category
    }
    
    init() {
    }
    
    private let webService = WebService.shared
    
    var categoryList: CategoriesModel = []
    
    func fetchCategories(completion: @escaping (() -> Void)) {
        webService.fetchCategories(categoryEnum: category) { [weak self] category in
            guard let self = self else { return }
            self.categoryList = category ?? []
            completion()
        }
    }
    
}
