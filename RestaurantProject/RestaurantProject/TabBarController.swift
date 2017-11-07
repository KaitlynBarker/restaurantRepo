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
        let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
        let searchNav = storyboard1.instantiateViewController(withIdentifier: "RestaurantSearch")
        let searchNavController = UINavigationController(rootViewController: searchNav)
        searchNav.title = "Search"
        
        let favsNav = storyboard1.instantiateViewController(withIdentifier: "FavoritesList")
        let favsNavController = UINavigationController(rootViewController: favsNav)
        favsNav.title = "Favorites"
        favsNav.tabBarItem.image = #imageLiteral(resourceName: "heart") 
        
        let toTryNav = storyboard1.instantiateViewController(withIdentifier: "ToTrysList")
        let toTryNavController = UINavigationController(rootViewController: toTryNav)
        toTryNav.title = "To Try"
        toTryNav.tabBarItem.image = #imageLiteral(resourceName: "taskList")
        
        let mapNav = storyboard1.instantiateViewController(withIdentifier: "MapView")
        let mapNavController = UINavigationController(rootViewController: mapNav)
        mapNav.title = "Map"
        mapNav.tabBarItem.image = #imageLiteral(resourceName: "map")
        
        viewControllers = [searchNavController, favsNavController, toTryNavController, mapNavController]
    }
}
