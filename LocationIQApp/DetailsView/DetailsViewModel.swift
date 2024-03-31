//
//  DetailsViewModel.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 01.04.24.
//

import Foundation
import MapKit

final class DetailsViewModel {
    
    var location: SearchModelElement?
    var lat = ""
    var lon = ""
    
    init() {}
    
    init(location: SearchModelElement) {
        self.location = location
        configure()
    }
    
    func configure() {
        lat = location?.lat ?? ""
        lon = location?.lon ?? ""
    }
    
    func setAnnotations() -> [MKPointAnnotation] {
        var annotations: [MKPointAnnotation] = []
        let annotation = MKPointAnnotation()
        let lat = Double(location?.lat ?? "") ?? 0.0
        let lon = Double(location?.lon ?? "") ?? 0.0
        annotation.title = location?.displayName ?? ""
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        annotations.append(annotation)
        return annotations
    }
}
