//
//  MapViewController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 10/9/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        self.mapView.showsScale = true
        self.mapView.showsPointsOfInterest = true
        self.mapView.showsUserLocation = true

    }
    
    func calculateDirections() {
        let startCoordinates = LocationManager.shared.fetchCurrentLocation()
        
        RestaurantController.shared.convertAddressToCoordinates { (coordinates) in
            let startPlacemark = MKPlacemark(coordinate: startCoordinates)
            let endPlacemark = MKPlacemark(coordinate: coordinates)
            
            let startItem = MKMapItem(placemark: startPlacemark)
            let endItem = MKMapItem(placemark: endPlacemark)
            
            let directionRequest = MKDirectionsRequest()
            directionRequest.source = startItem
            directionRequest.destination = endItem
            directionRequest.transportType = .any
            
            let directions = MKDirections(request: directionRequest)
            directions.calculate { (response, error) in
                guard let response = response else { return }
                
                if let error = error {
                    NSLog("Error found. \(error.localizedDescription)")
                    return
                }
                
                let route = response.routes[0]
                self.mapView.add(route.polyline, level: .aboveRoads)
                
                let rect = route.polyline.boundingMapRect
                let region = MKCoordinateRegionForMapRect(rect)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 2.5
        
        return renderer
    }
}
