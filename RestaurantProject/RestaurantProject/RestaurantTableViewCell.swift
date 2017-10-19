//
//  RestaurantTableViewCell.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/13/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var aveCostForTwoLabel: UILabel!
    
    var restaurant: Restaurant? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let restaurant = restaurant, let imageURL = restaurant.imageURL else { return }
        
        self.backgroundColor = UIColor.customGrey
        self.restaurantNameLabel.textColor = UIColor.customBlue
        self.aveCostForTwoLabel.textColor = UIColor.customBlue
        
        RestaurantController.shared.fetchRestaurantImage(imageURL: imageURL) { (image) in
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                self.restaurantImageView.image = image
                self.restaurantNameLabel.text = restaurant.restaurantName
                self.aveCostForTwoLabel.text = "Ave Cost For Two: $\(restaurant.averageCostForTwo)"
            }
        }
    }
}
