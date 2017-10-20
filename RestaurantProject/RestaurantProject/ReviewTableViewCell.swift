//
//  ReviewTableViewCell.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/14/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var ratingTextLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingTimeLabel: UILabel!
    @IBOutlet weak var reviewTextLabel: UILabel!
    
    var review: Review? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let review = review else { return }
        
        self.backgroundColor = UIColor.customGrey
        self.ratingTextLabel.textColor = UIColor.customBlue
        self.ratingLabel.textColor = UIColor.customBlue
        self.ratingTimeLabel.textColor = UIColor.customBlue
        self.reviewTextLabel.textColor = UIColor.customBlue
        
        calculateRating()
        
        self.ratingTextLabel.text = review.ratingText
        self.ratingTimeLabel.text = review.reviewPostTime
        self.reviewTextLabel.text = review.reviewText
    }
    
    func calculateRating() {
        guard let review = review else { return }
        
        if review.rating == 1 {
            self.ratingLabel.text = "Rating: ★"
        } else if review.rating == 2 {
            self.ratingLabel.text = "Rating: ★★"
        } else if review.rating == 3 {
            self.ratingLabel.text = "Rating: ★★★"
        } else if review.rating == 4 {
            self.ratingLabel.text = "Rating: ★★★★"
        } else {
            self.ratingLabel.text = "Rating: ★★★★★"
        }
    }
    
}
