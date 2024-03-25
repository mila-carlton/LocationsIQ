//
//  SearchModel.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 25.03.24.
//

import Foundation

struct SearchModelElement: Codable {
    
    let placeID: String?
    let licence: String?
    let osmType, osmID: String?
    let boundingbox: [String]?
    let lat, lon, displayName, searchModelClass: String?
    let type: String?
    let importance: Double?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case licence
        case osmType = "osm_type"
        case osmID = "osm_id"
        case boundingbox, lat, lon
        case displayName = "display_name"
        case searchModelClass = "class"
        case type, importance, icon
    }
}

typealias SearchModel = [SearchModelElement]
