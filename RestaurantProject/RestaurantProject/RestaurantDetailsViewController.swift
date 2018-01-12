//
//  RestaurantDetailsViewController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/13/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit
import MapKit

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
        self.view.backgroundColor = UIColor.customIvory
        
        self.buttonStackView.backgroundColor = UIColor.customIvory
        self.favoriteButton.backgroundColor = UIColor.customIvory
        self.toTryButton.backgroundColor = UIColor.customIvory
        self.takeMeHereButton.backgroundColor = UIColor.customIvory
        self.restaurantNameLabel.backgroundColor = UIColor.customIvory
        self.restaurantAddressLabel.backgroundColor = UIColor.customIvory
        self.aveCostForTwoLabel.backgroundColor = UIColor.customIvory
        self.averageRatingLabel.backgroundColor = UIColor.customIvory
        self.ratingTextLabel.backgroundColor = UIColor.customIvory
        self.numberOfVotesLabel.backgroundColor = UIColor.customIvory
        
        self.restaurantNameLabel.textColor = UIColor.customMaroon
        self.restaurantAddressLabel.textColor = UIColor.customMaroon
        self.aveCostForTwoLabel.textColor = UIColor.customMaroon
        self.averageRatingLabel.textColor = UIColor.customMaroon
        self.ratingTextLabel.textColor = UIColor.customMaroon
        self.numberOfVotesLabel.textColor = UIColor.customMaroon
        
        guard let restaurant = self.restaurant else { return }
        
        if restaurant.isFavorited == true {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "filledHeart"), for: .normal)
        } else {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        }
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
        guard let restaurant = self.restaurant else { return }
        
        RestaurantController.shared.convertAddressToCoordinates(restaurant: restaurant) { (coordinates) in
            
            let regionDistance: CLLocationDistance = 1000
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
            
            let placemark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placemark)
            
            mapItem.name = restaurant.restaurantName
            mapItem.openInMaps(launchOptions: options)
        }
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
                self.averageRatingLabel.text = "Average Rating: \(aveRating.capitalized)/5"
                self.ratingTextLabel.text = "Rating Text: \(ratingText.capitalized)"
                self.numberOfVotesLabel.text = "Number of Votes: \(numOfVotes.capitalized)"
                self.restaurantImageView.image = image
            }
        }
    }
}

