//
//  RestaurantDetailsViewController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/13/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class RestaurantDetailsViewController: UIViewController {
    
    var restaurant: Restaurant? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    // buttons
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var toTryButton: UIButton!
    @IBOutlet weak var callRestaurantButton: UIButton!
    @IBOutlet weak var takeMeHereButton: UIButton!
    
    // description labels
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var aveCostForTwoLabel: UILabel!
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var ratingTextLabel: UILabel!
    @IBOutlet weak var numberOfVotesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = restaurant?.restaurantName
        self.view.backgroundColor = UIColor.customGrey
        
        self.buttonStackView.backgroundColor = UIColor.customGrey
        self.favoriteButton.backgroundColor = UIColor.customGrey
        self.toTryButton.backgroundColor = UIColor.customGrey
        self.callRestaurantButton.backgroundColor = UIColor.customGrey
        self.restaurantNameLabel.backgroundColor = UIColor.customGrey
        self.restaurantAddressLabel.backgroundColor = UIColor.customGrey
        self.aveCostForTwoLabel.backgroundColor = UIColor.customGrey
        self.averageRatingLabel.backgroundColor = UIColor.customGrey
        self.ratingTextLabel.backgroundColor = UIColor.customGrey
        self.numberOfVotesLabel.backgroundColor = UIColor.customGrey
        
        self.restaurantNameLabel.textColor = UIColor.customBlue
        self.restaurantAddressLabel.textColor = UIColor.customBlue
        self.aveCostForTwoLabel.textColor = UIColor.customBlue
        self.averageRatingLabel.textColor = UIColor.customBlue
        self.ratingTextLabel.textColor = UIColor.customBlue
        self.numberOfVotesLabel.textColor = UIColor.customBlue
        self.takeMeHereButton.titleLabel?.textColor = UIColor.customBlue
    }
    
    //MARK: - Actions
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard let restaurant = self.restaurant else { return }
        RestaurantController.shared.isFavoritedToggle(restaurant: restaurant)
        
        if restaurant.isFavorited {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "filledHeart"), for: .normal)
        } else {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        }
    }
    
    @IBAction func callRestaurantButtonTapped(_ sender: UIButton) {
        self.callRestaurantAlert()
    }
    
    @IBAction func toTryButtonTapped(_ sender: UIButton) {
        guard let restaurant = self.restaurant else { return }
        RestaurantController.shared.toTryListToggle(restaurant: restaurant)
        
        if restaurant.isOnToTryList {
            self.toTryButton.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        } else {
            self.toTryButton.setImage(#imageLiteral(resourceName: "taskList"), for: .normal)
        }
    }
    
    @IBAction func takeMeHereButtonTapped(_ sender: UIButton) {
        // FIXME: - actually put something in this function
    }
    
    //MARK: - Linking outlets to restaurant info
    
    func updateViews() {
        guard let restaurant = restaurant, let image = restaurant.imageURL, let aveRating = restaurant.averageRating, let ratingText = restaurant.ratingText, let numOfVotes = restaurant.numberOfVotes else { return }
        
        RestaurantController.shared.fetchRestaurantImage(imageURLString: image) { (image) in
            
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                self.restaurantNameLabel.text = restaurant.restaurantName
                self.restaurantAddressLabel.text = restaurant.address
                self.aveCostForTwoLabel.text = "Average Cost For Two: $\(restaurant.averageCostForTwo)"
                self.averageRatingLabel.text = "Average Rating: \(aveRating.capitalized)"
                self.ratingTextLabel.text = "Rating Text: \(ratingText.capitalized)"
                self.numberOfVotesLabel.text = "Number of Votes: \(numOfVotes.capitalized)"
                self.restaurantImageView.image = image
            }
        }
    }
    
    // MARK: - Call Restaurant Alert Controller
    
    func callRestaurantAlert() {
        guard let restaurant = self.restaurant, let restaurantName = restaurant.restaurantName else { return }
        RestaurantController.shared.fetchRestaurantPhoneNumber(restaurant: restaurant) { (phoneNumber) in
            let alertController = UIAlertController(title: "Call \(restaurantName)?", message: phoneNumber, preferredStyle: .alert)
            let callAction = UIAlertAction(title: "Call", style: .default) { (_) in
                if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(callAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
