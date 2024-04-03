//
//  DetailsViewController.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 01.04.24.
//

import UIKit
import MapKit
import CoreLocation

final class DetailsViewController: UIViewController, MKMapViewDelegate {
    
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
        label.text = viewModel.item?.displayName
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
    
    let viewModel: DetailsViewModel
    
    let locationManager = CLLocationManager()
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupActions()
    }
    
    private func setupLayout() {
        mapView.delegate = self
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            mapView.heightAnchor.constraint(equalToConstant: 300),
            
            addressStaticLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16),
            addressStaticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            addressStaticLabel.widthAnchor.constraint(equalToConstant: 90),
            addressStaticLabel.heightAnchor.constraint(equalToConstant: 28),
            
            addressLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16),
            addressLabel.leadingAnchor.constraint(equalTo: addressStaticLabel.trailingAnchor, constant: 2),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            addressLabel.centerYAnchor.constraint(equalTo: addressStaticLabel.centerYAnchor),
            addressLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 28),
            
            routeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
            routeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            routeButton.widthAnchor.constraint(equalToConstant: 280),
            routeButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func updateMap() {
        mapView.addAnnotations(viewModel.makeAnnotations())
        addressLabel.text = "Address: \(viewModel.item?.displayName ?? "")"
    }
    
    private func setupActions() {
        routeButton.addTarget(self, action: #selector(routeButtonTapped), for: .touchUpInside)
    }
    
    @objc func routeButtonTapped() {
        let actionSheet = UIAlertController(title: "Alert Action", message: "Choose for Direction", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Here", style: .default) { _ in
            self.getAdressHere()
        })
        
        actionSheet.addAction(UIAlertAction(title: "Go Maps", style: .default) { _ in
            self.getAdressOnMaps()
        })
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
    func getAdressHere() {
        guard let sourceLat = Double(viewModel.item?.lat ?? ""), let sourceLon = Double(viewModel.item?.lon ?? "") else { return }
        let sourceLocation = CLLocationCoordinate2D(latitude: sourceLat, longitude: sourceLon)
        let destinationLocation = CLLocationCoordinate2D(latitude: Double(viewModel.item?.lat ?? "") ?? 0.0, longitude: Double(viewModel.item?.lon ?? "") ?? 0.0)
        routeHere(sourceLocation: sourceLocation, destinationLocation: destinationLocation)
    }
    
    func getAdressOnMaps() {
        guard let lat = Double(viewModel.item?.lat ?? ""), let lon = Double(viewModel.item?.lon ?? "") else { return }
        let requestLocation = CLLocation(latitude: lat, longitude: lon)
        
        CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
            if let placemark = placemarks?.first {
                let newPlacemark = MKPlacemark(placemark: placemark)
                let item = MKMapItem(placemark: newPlacemark)
                item.name = self.viewModel.item?.displayName
                let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                item.openInMaps(launchOptions: launchOptions)
            }
        }
    }
    
    func routeHere(sourceLocation: CLLocationCoordinate2D, destinationLocation: CLLocationCoordinate2D) {
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let direction = MKDirections(request: directionRequest)
        
        direction.calculate { response, error in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
}

extension DetailsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
}
