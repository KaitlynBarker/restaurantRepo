//
//  TabBarController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 10/18/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTabBar()
    }
    
    func customTabBar() {
        let storyboard1 = UIStoryboard(name: "RestaurantViews", bundle: nil)
        let navigationController = storyboard1.instantiateViewController(withIdentifier: "RestaurantSearch")
        let secondNavigationController = UINavigationController(rootViewController: navigationController)
        navigationController.title = "Search"
        
        let storyboard2 = UIStoryboard(name: "Favorites", bundle: nil)
        let navigationController2 = storyboard2.instantiateViewController(withIdentifier: "FavoritesList")
        let secondNavController = UINavigationController(rootViewController: navigationController2)
        navigationController2.title = "Favorites"
        
        let storyboard3 = UIStoryboard(name: "ToTrys", bundle: nil)
        let navigationController3 = storyboard3.instantiateViewController(withIdentifier: "ToTrysList")
        let secondNavController3 = UINavigationController(rootViewController: navigationController3)
        navigationController3.title = "To Try List"
        
        let storyboard4 = UIStoryboard(name: "MapView", bundle: nil)
        let navigationController4 = storyboard4.instantiateViewController(withIdentifier: "MapView")
        let lastNavController = UINavigationController(rootViewController: navigationController4)
        navigationController4.title = "Map"
        
        viewControllers = [secondNavigationController, secondNavController, secondNavController3, lastNavController]
    }
}
