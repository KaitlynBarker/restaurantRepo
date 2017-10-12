//
//  LocationManager.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 10/11/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    let locationManager = CLLocationManager()
    
    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func fetchCurrentLocation() -> CLLocationCoordinate2D {
        guard let currentCoordinates = locationManager.location?.coordinate else { return CLLocationCoordinate2D() }
        return currentCoordinates
    }
}
