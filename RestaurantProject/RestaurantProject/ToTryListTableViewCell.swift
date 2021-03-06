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
    @IBOutlet weak var toTryButton: UIButton!
    @IBOutlet weak var avePriceForTwo: UILabel!
    
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
        
        self.backgroundColor = UIColor.customIvory
        self.toTryButton.backgroundColor = UIColor.customIvory
        self.nameLabel.textColor = UIColor.customMaroon
        self.avePriceForTwo.textColor = UIColor.customMaroon
        
        RestaurantController.shared.fetchRestaurantImage(imageURLString: imageURL) { (image) in
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                self.restaurantImageView.image = image
                self.nameLabel.text = toTryRes.restaurantName
                self.avePriceForTwo.text = "Ave Price For Two: $\(toTryRes.averageCostForTwo)"
                
                if toTryRes.isOnToTryList {
                    self.toTryButton.setImage(#imageLiteral(resourceName: "list"), for: .normal)
                } else {
                    self.toTryButton.setImage(#imageLiteral(resourceName: "taskList"), for: .normal)
                }
            }
        }
    }
}

protocol ToTryListTableViewCellDelegate: class {
    func restaurantStatusWasUpdate(cell: ToTryListTableViewCell)
}
