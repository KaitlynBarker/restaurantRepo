//
//  CuisineTableViewCell.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/15/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class CuisineTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var cuisineNameLabel: UILabel!
    @IBOutlet weak var cuisineCheckBoxButton: UIButton!
    
    //MARK: - Actions
    
    @IBAction func cuisineCheckBoxButtonTapped(_ sender: UIButton) {
        delegate?.cuisineCellWasUpdated(cell: self)
    }
    
    weak var delegate: CuisineTableViewCellDelegate?
    
    var cuisine: Cuisine? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let cuisine = cuisine else { return }
        cuisineNameLabel.text = cuisine.cuisineName
        
        self.backgroundColor = UIColor.customIvory
        self.cuisineCheckBoxButton.backgroundColor = UIColor.customIvory
        
        if cuisine.isCuisineChosen {
            cuisineCheckBoxButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
            cuisineNameLabel.textColor = UIColor.candyAppleRed
        } else {
            cuisineCheckBoxButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
            cuisineNameLabel.textColor = UIColor.customMaroon
        }
    }
}

protocol CuisineTableViewCellDelegate: class {
    func cuisineCellWasUpdated(cell: CuisineTableViewCell)
}
