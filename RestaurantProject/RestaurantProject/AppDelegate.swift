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
        
        let temporaryDirectory = NSTemporaryDirectory()
        let urlCache = URLCache(memoryCapacity: 25000000, diskCapacity: 50000000, diskPath: temporaryDirectory)
        URLCache.shared = urlCache
        
        let navBarAppearance = UINavigationBar.appearance()
        let labelAppearance = UILabel.appearance()
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        let buttonAppearance = UIButton.appearance()
        
        navBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.customBlue, NSAttributedStringKey.font: UIFont.navBarTitle]
        
        labelAppearance.font = UIFont.labelFont
        barButtonItemAppearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.customBlue, NSAttributedStringKey.font: UIFont.barButtonFont], for: .normal)
        buttonAppearance.titleLabel?.font = UIFont.merriweatherLight
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let customTabBar = storyboard.instantiateViewController(withIdentifier: "CustomTabBar") as? CustomTabBarController else { return false }
        
        window?.rootViewController = customTabBar
        window?.makeKeyAndVisible()
        
        LocationManager.shared.requestAuthorization()
        
        RestaurantController.shared.fetchNearbyRestaurants()
        
        return true
    }
}

