//
//  WebService.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 22.03.24.
//

import Foundation

final class WebService {
    
    static let shared = WebService()
    private init() { }
    
    func fetchCategories(categoryEnum: CategoriesEnum, completion: @escaping (([CategoriesModelElement]?) -> Void) ) {
        let url = URL(string: "https://us1.locationiq.com/v1/nearby?key=\(apiKey)&lat=40.712776&lon=-74.005974&tag=amenity:\(categoryEnum.rawValue)&radius=5000&format=json")!
        
        NetworkRequest.shared.requestAPI(type: CategoriesModel.self, url: url.absoluteString) { result in
            switch result {
            case .success(let categories):
                completion(categories)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func fetchSearch(query: String, completion: @escaping (([SearchModelElement]?) -> Void)) {
        let q = query.replacingOccurrences(of: " ", with: "_")
        let url = URL(string: "https://us1.locationiq.com/v1/search?key=\(apiKey)&q=\(q)&format=json")!
        NetworkRequest.shared.requestAPI(type: SearchModel.self, url: url.absoluteString) { result in
            switch result {
            case .success(let search):
                completion(search)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
