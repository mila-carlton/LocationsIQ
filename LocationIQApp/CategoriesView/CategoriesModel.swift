//
//  CategoriesModel.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 22.03.24.
//

import UIKit

struct Category {
    let name: String
    let image: UIImage
    let category: CategoriesEnum
}

class CategoriesManager {
    static let shared = CategoriesManager()
    
    var categories: [Category] = [
        
        Category(name: "All", image: UIImage(systemName: "square.grid.3x3.fill")!, category: .all),
        Category(name: "Airport", image: UIImage(systemName: "airplane.circle")!, category: .airport),
        Category(name: "Restaurant", image: UIImage(systemName: "fork.knife")!, category: .restaurant),
        Category(name: "Bank", image: UIImage(systemName: "building.columns.fill")!, category: .bank),
        Category(name: "ATM", image: UIImage(systemName: "dollarsign.circle")!, category: .atm),
        Category(name: "Hotel", image: UIImage(systemName: "building.2")!, category: .hotel),
        Category(name: "Pub", image: UIImage(systemName: "person")!, category: .pub),
        Category(name: "Bus Station", image: UIImage(systemName: "bus")!, category: .busStation),
        Category(name: "Railway Station", image: UIImage(systemName: "tram.fill")!,category: .railwayStation),
        Category(name: "Cinema", image: UIImage(systemName: "film")!, category: .cinema),
        Category(name: "Hospital", image: UIImage(systemName: "cross.circle")!, category: .hospital),
        Category(name: "College", image: UIImage(systemName: "graduationcap.fill")!, category: .college)
    ]
    
    private init() {}
}


enum CategoriesEnum: String {
    case all = "*"
    case airport = "airport"
    case restaurant = "restaurant"
    case bank = "bank"
    case atm = "atm"
    case hotel = "hotel"
    case pub = "pub"
    case busStation = "bus station"
    case railwayStation = "railway station"
    case cinema = "cinema"
    case hospital = "hospital"
    case college = "college"
    
    
}
