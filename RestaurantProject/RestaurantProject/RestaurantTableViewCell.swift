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
        guard let restaurant = restaurant, let image = restaurant.imageURL else { return }
        
        self.backgroundColor = UIColor.blueGrey60
        self.restaurantNameLabel.textColor = UIColor.peach30
        self.restaurantDistanceLabel.textColor = UIColor.peach30
        self.averagePriceLabel.textColor = UIColor.peach30
        
        RestaurantController.shared.fetchRestaurantImage(imageURL: image) { (image) in
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                self.restaurantImageView.image = image
                self.restaurantNameLabel.text = restaurant.restaurantName
                self.restaurantDistanceLabel.text = "Approx. " // i should be able to figure this out after i do map kit
                
                self.calculateAvePrice()
            }
        }
    }
    
    func calculateAvePrice() {
        guard let restaurant = restaurant else { return }
        
        if restaurant.priceRange == 1 {
            self.averagePriceLabel.text = "Average Price: 💲"
        } else if restaurant.priceRange == 2 {
            self.averagePriceLabel.text = "Average Price: 💲💲"
        } else if restaurant.priceRange == 3 {
            self.averagePriceLabel.text = "Average Price: 💲💲💲"
        } else if restaurant.priceRange == 4 {
            self.averagePriceLabel.text = "Average Price: 💲💲💲💲"
        } else {
            self.averagePriceLabel.text = "Average Price: 💲💲💲💲💲"
        }
    }
    
}
