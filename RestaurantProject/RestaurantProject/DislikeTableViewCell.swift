//
//  DislikeTableViewCell.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 10/10/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class DislikeTableViewCell: UITableViewCell {
    
    var dislikeRes: Restaurant? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
    }
}
