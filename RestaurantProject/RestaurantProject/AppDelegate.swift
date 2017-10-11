//
//  AppDelegate.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/12/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let locationManager = MapViewController.shared.locationManager
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
//        RestaurantController.shared.fetchRestaurantInfo { (restaurants) in
//            //
//        }
        
//        ReviewController.shared.fetchReviews { (reviews) in
//            //
//        }
        
        return true
    }
}

