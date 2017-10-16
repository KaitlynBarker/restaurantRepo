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
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        delegate?.restaurantStatusWasUpdated(cell: self)
    }
    
    weak var delegate: FavoriteTableViewCellDelegate?
    
    var favoriteRes: Restaurant? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let favRestaurant = self.favoriteRes, let image = favRestaurant.imageURL else { return }
        
        self.backgroundColor = UIColor.blueGrey60
        self.favoriteButton.backgroundColor = UIColor.blueGrey60
        self.restaurantNameLabel.textColor = UIColor.peach30
        self.resDistanceLabel.textColor = UIColor.peach30
        self.avePriceLabel.textColor = UIColor.peach30
        
        RestaurantController.shared.fetchRestaurantImage(imageURL: image) { (image) in
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                self.restaurantImageView.image = image
                self.restaurantNameLabel.text = favRestaurant.restaurantName
                self.resDistanceLabel.text = "" // will find this out after i incorporate map kit
                
                self.calculateAvePrice()
                
                if favRestaurant.isFavorited {
                    self.favoriteButton.setImage(#imageLiteral(resourceName: "filledHeart"), for: .normal)
                } else {
                    self.favoriteButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
                }
            }
        }
    }
    
    func calculateAvePrice() {
        guard let favRestaurant = self.favoriteRes else { return }
        
        if favRestaurant.priceRange == 1 {
            self.avePriceLabel.text = "Expected Price: 💲"
        } else if favRestaurant.priceRange == 2 {
            self.avePriceLabel.text = "Expected Price: 💲💲"
        } else if favRestaurant.priceRange == 3 {
            self.avePriceLabel.text = "Expected Price: 💲💲💲"
        } else if favRestaurant.priceRange == 4 {
            self.avePriceLabel.text = "Expected Price: 💲💲💲💲"
        } else {
            self.avePriceLabel.text = "Expected Price: 💲💲💲💲💲"
        }
    }
}

// FIXME: - incorporate protocol properly.

protocol FavoriteTableViewCellDelegate: class {
    func restaurantStatusWasUpdated(cell: FavoriteTableViewCell)
}
