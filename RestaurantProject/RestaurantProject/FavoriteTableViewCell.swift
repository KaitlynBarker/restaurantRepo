//
//  FavoriteTableViewCell.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 10/9/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var resDistanceLabel: UILabel!
    @IBOutlet weak var avePriceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        
    }
    
    var favoriteRes: Restaurant? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
    }
}
