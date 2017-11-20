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
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var avePriceForTwo: UILabel!
    
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
        
        self.backgroundColor = UIColor.customIvory
        self.favoriteButton.backgroundColor = UIColor.customIvory
        self.restaurantNameLabel.textColor = UIColor.customMaroon
        self.avePriceForTwo.textColor = UIColor.customMaroon
        
        RestaurantController.shared.fetchRestaurantImage(imageURLString: image) { (image) in
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                self.restaurantImageView.image = image
                self.restaurantNameLabel.text = favRestaurant.restaurantName
                self.avePriceForTwo.text = "Ave Price For Two: $\(favRestaurant.averageCostForTwo)"
                
                if favRestaurant.isFavorited {
                    self.favoriteButton.setImage(#imageLiteral(resourceName: "filledHeart"), for: .normal)
                } else {
                    self.favoriteButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
                }
            }
        }
    }
}

// FIXME: - incorporate protocol properly.

protocol FavoriteTableViewCellDelegate: class {
    func restaurantStatusWasUpdated(cell: FavoriteTableViewCell)
}
