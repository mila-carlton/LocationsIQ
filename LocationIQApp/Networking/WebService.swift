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
        let url = URL(string: "https://us1.locationiq.com/v1/nearby?key=\(apiKey)&lat=40.407183&lon=49.867136&tag=amenity:\(categoryEnum.rawValue)&radius=5000&format=json")!
        
        NetworkRequest.shared.requestAPI(type: CategoriesModel.self, url: url.absoluteString) { result in
            switch result {
            case .success(let categories):
                completion(categories)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
}
