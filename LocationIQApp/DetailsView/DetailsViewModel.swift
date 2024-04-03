//
//  DetailsViewModel.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 01.04.24.
//

import Foundation
import MapKit

final class DetailsViewModel {
    
    private var location: SearchModelElement?
    
    var item: SearchModelElement? {
        return location
    }
    
    init(location: SearchModelElement) {
        self.location = location
    }
    
    func makeAnnotations() -> [MKPointAnnotation] {
        guard let location = location else { return [] }
        
        let annotation = MKPointAnnotation()
        if let lat = Double(location.lat ?? ""), let lon = Double(location.lon ?? "") {
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        annotation.title = location.displayName
        
        return [annotation]
    }
}
