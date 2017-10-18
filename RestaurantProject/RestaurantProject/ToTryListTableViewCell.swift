//
//  ToTryListTableViewCell.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 10/13/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class ToTryListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var avePriceLabel: UILabel!
    @IBOutlet weak var toTryButton: UIButton!
    
    
    
    // MARK: - Actions
    
    @IBAction func toTryButtonTapped(_ sender: UIButton) {
        delegate?.restaurantStatusWasUpdate(cell: self)
    }
    
    weak var delegate: ToTryListTableViewCellDelegate?
    
    var toTryRes: Restaurant? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let toTryRes = self.toTryRes, let imageURL = toTryRes.imageURL else { return }
        
        //        self.backgroundColor = UIColor.blueGrey60
        //        self.toTryButton.backgroundColor = UIColor.blueGrey60
        //        self.nameLabel.textColor = UIColor.peach30
        //        self.distanceLabel.textColor = UIColor.peach30
        //        self.avePriceLabel.textColor = UIColor.peach30
        
        RestaurantController.shared.fetchRestaurantImage(imageURL: imageURL) { (image) in
            guard let image = image else { return }
            
            //            RestaurantController.shared.convertAddressToDistance { (distance) in
            //                let distance = distance
            
            DispatchQueue.main.async {
                self.restaurantImageView.image = image
                self.nameLabel.text = toTryRes.restaurantName
                //                    self.distanceLabel.text = "Approx \(distance) away"
                
                self.calculateAvePrice()
                
                if toTryRes.isOnToTryList {
                    // set image
                } else {
                    // set image
                }
            }
            //            }
        }
    }
    
    func calculateAvePrice() {
        guard let toTryRes = self.toTryRes else { return }
        
        if toTryRes.priceRange == 1 {
            self.avePriceLabel.text = "Expected Price: 💲"
        } else if toTryRes.priceRange == 2 {
            self.avePriceLabel.text = "Expected Price: 💲💲"
        } else if toTryRes.priceRange == 3 {
            self.avePriceLabel.text = "Expected Price: 💲💲💲"
        } else if toTryRes.priceRange == 4 {
            self.avePriceLabel.text = "Expected Price: 💲💲💲💲"
        } else {
            self.avePriceLabel.text = "Expected Price: 💲💲💲💲💲"
        }
    }
}

protocol ToTryListTableViewCellDelegate: class {
    func restaurantStatusWasUpdate(cell: ToTryListTableViewCell)
}
