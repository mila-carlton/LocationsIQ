//
//  DetailsViewController.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 01.04.24.
//

import UIKit
import MapKit
import CoreLocation

final class DetailsViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(map)
        return map
    }()
    
    private lazy var addressStaticLabel: UILabel = {
        let label = UILabel()
        label.text = "Address:"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    
    private lazy var routeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Route", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            mapView.heightAnchor.constraint(equalToConstant: 300),
            
            addressStaticLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16),
            addressStaticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            addressStaticLabel.widthAnchor.constraint(equalToConstant: 80),
            addressStaticLabel.heightAnchor.constraint(equalToConstant: 28),
            
            addressLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16),
            addressLabel.leadingAnchor.constraint(equalTo: addressStaticLabel.trailingAnchor, constant: 2),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            addressLabel.heightAnchor.constraint(equalToConstant: 120),
            
            routeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            routeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            routeButton.widthAnchor.constraint(equalToConstant: 80),
            routeButton.heightAnchor.constraint(equalToConstant: 60)
          
        ])
    }

}
