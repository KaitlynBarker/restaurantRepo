//
//  ThumbsDownTableViewCell.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 10/12/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class ThumbsDownTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var avePriceLabel: UILabel!
    @IBOutlet weak var thumbsDownButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func thumbsDownButtonTapped(_ sender: UIButton) {
        delegate?.restaurantStatusWasUpdate(cell: self)
    }
    
    weak var delegate: ThumbsDownTableViewCellDelegate?
    
    var thumbsDownRes: Restaurant? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let thumbsDownRes = self.thumbsDownRes, let image = thumbsDownRes.imageURL else { return }
        
        RestaurantController.shared.fetchRestaurantImage(imageURL: image) { (image) in
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                self.restaurantImageView.image = image
                self.nameLabel.text = thumbsDownRes.restaurantName
                self.distanceLabel.text = "" // map kit will help figure this out
                
                self.calculateAvePrice()
                
                if thumbsDownRes.isThumbsDown {
                    // set image
                } else {
                    // set image
                }
            }
        }
    }
    
    func calculateAvePrice() {
        guard let thumbsDownRes = self.thumbsDownRes else { return }
        
        if thumbsDownRes.priceRange == 1 {
            self.avePriceLabel.text = "Expected Price: 💲"
        } else if thumbsDownRes.priceRange == 2 {
            self.avePriceLabel.text = "Expected Price: 💲💲"
        } else if thumbsDownRes.priceRange == 3 {
            self.avePriceLabel.text = "Expected Price: 💲💲💲"
        } else if thumbsDownRes.priceRange == 4 {
            self.avePriceLabel.text = "Expected Price: 💲💲💲💲"
        } else {
            self.avePriceLabel.text = "Expected Price: 💲💲💲💲💲"
        }
    }
}

protocol ThumbsDownTableViewCellDelegate: class {
    func restaurantStatusWasUpdate(cell: ThumbsDownTableViewCell)
}
