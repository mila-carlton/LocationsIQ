//
//  CategoryResponseModel.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 23.03.24.
//

import Foundation

typealias CategoriesModel = [CategoriesModelElement]

struct CategoriesModelElement: Codable {
    let placeID: String?
    let osmType: String?
    let osmID, lat, lon: String?
    let categoriesModelClass: String?
    let type, tagType: String?
    let name, displayName: String?
    let address: Address?
    let boundingbox: [String]?
    let distance: Int?

    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case osmType = "osm_type"
        case osmID = "osm_id"
        case lat, lon
        case categoriesModelClass = "class"
        case type
        case tagType = "tag_type"
        case name
        case displayName = "display_name"
        case address, boundingbox, distance
    }
}


struct Address: Codable {
    let name, road: String?
    let city: String?
    let state: String?
    let postcode: String?
    let country: String?
    let countryCode: String?
    let houseNumber: String?

    enum CodingKeys: String, CodingKey {
        case name, road, city, state, postcode, country
        case countryCode = "country_code"
        case houseNumber = "house_number"
    }
}


