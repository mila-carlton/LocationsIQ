//
//  ListViewController.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 23.03.24.
//

import UIKit
import MapKit
import CoreLocation

final class ListViewController: UIViewController {
    
    private lazy var listSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        segmentControl.insertSegment(withTitle: "List", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "Map", at: 1, animated: true)
        segmentControl.addTarget(self, action: #selector(segmentControlAction), for: .valueChanged)
        view.addSubview(segmentControl)
        return segmentControl
    }()
    
    private lazy var listTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
        tableView.rowHeight = 50
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        return tableView
    }()
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.showsUserLocation = true
        map.delegate = self
        view.addSubview(map)
        return map
    }()
    
    
    private var viewModel: ListViewModel
    
    private var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        return manager
    }()
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.fetchCategories {
            DispatchQueue.main.async {
                self.listTableView.reloadData()
                self.setPointAnnotations()
            }
        }
        
    }
    
    
    private func setPointAnnotations() {
        
        var zoomRect = MKMapRect.null
        
        for category in viewModel.categoryList {
            let annotations = MKPointAnnotation()
            annotations.title = category.name
            annotations.coordinate = CLLocationCoordinate2D(latitude: Double(category.lat ?? "")!,
                                                            longitude:  Double(category.lon ?? "")!)
            let annotationPoint = MKMapPoint(annotations.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0, height: 0)
            zoomRect = zoomRect.union(pointRect)
            let padding = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
            mapView.setVisibleMapRect(zoomRect, edgePadding: padding, animated: true)
            self.mapView.addAnnotation(annotations)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        listSegmentControl.selectedSegmentIndex = 0
        segmentControlAction()
        locationManager.delegate = self

        locationManager.requestWhenInUseAuthorization()
    }
    
    @objc func segmentControlAction() {
        switch self.listSegmentControl.selectedSegmentIndex {
            
        case 0:
            self.listTableView.isHidden = false
            self.mapView.isHidden = true
            
        case 1:
            self.listTableView.isHidden = true
            self.mapView.isHidden = false
            
        default:
            self.listTableView.isHidden = true
            self.mapView.isHidden = true
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white.withAlphaComponent(0.8)
        
        NSLayoutConstraint.activate([
            listSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            listSegmentControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            listSegmentControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            listSegmentControl.heightAnchor.constraint(equalToConstant: 40),
            
            listTableView.topAnchor.constraint(equalTo: listSegmentControl.safeAreaLayoutGuide.bottomAnchor, constant: 12),
            listTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            
            mapView.topAnchor.constraint(equalTo: listSegmentControl.safeAreaLayoutGuide.bottomAnchor, constant: 12),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as! ListTableViewCell
        cell.configure(listItem: viewModel.categoryList[indexPath.row])
        return cell
    }
    
}
extension ListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
        }
    }
}

extension ListViewController: MKMapViewDelegate {
    
}
