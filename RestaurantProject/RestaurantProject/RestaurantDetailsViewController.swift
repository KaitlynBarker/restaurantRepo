//
//  RestaurantDetailsViewController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/13/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class RestaurantDetailsViewController: UIViewController {
    
    var restuarant: Restaurant?
    
    //MARK: - Outlets

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = restuarant?.restaurantName
    }
    
    //MARK: - Actions

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
