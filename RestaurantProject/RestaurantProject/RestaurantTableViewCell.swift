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
    @IBOutlet weak var restaurantDistanceLabel: UILabel!
    @IBOutlet weak var averagePriceLabel: UILabel!
    
    var restaurant: Restaurant? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let restaurant = restaurant, let imageURL = restaurant.imageURL else { return }
        
        self.backgroundColor = UIColor.customGrey
        self.restaurantNameLabel.textColor = UIColor.customBlue
        self.restaurantDistanceLabel.textColor = UIColor.customBlue
        self.averagePriceLabel.textColor = UIColor.customBlue
        
        RestaurantController.shared.fetchRestaurantImage(imageURL: imageURL) { (image) in
            guard let image = image else { return }
            
//            RestaurantController.shared.convertAddressToDistance { (distance) in
//                let distance = distance
//            }
            
                DispatchQueue.main.async {
                    self.restaurantImageView.image = image
                    self.restaurantNameLabel.text = restaurant.restaurantName
//                    self.restaurantDistanceLabel.text = "Approx \(distance) away"
                
                    self.calculateAvePrice()
                }
        }
    }
    
    func calculateAvePrice() {
        guard let restaurant = restaurant else { return }
        
        if restaurant.priceRange == 1 {
            self.averagePriceLabel.text = "Average Price: 💰"
        } else if restaurant.priceRange == 2 {
            self.averagePriceLabel.text = "Average Price: 💰💰"
        } else if restaurant.priceRange == 3 {
            self.averagePriceLabel.text = "Average Price: 💰💰💰"
        } else if restaurant.priceRange == 4 {
            self.averagePriceLabel.text = "Average Price: 💰💰💰💰"
        } else {
            self.averagePriceLabel.text = "Average Price: 💰💰💰💰💰"
        }
    }
    
}
