//
//  RestaurantDetailsViewController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/13/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class RestaurantDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var restaurant: Restaurant? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var reviewTableView: UITableView!
    
    // buttons
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var toTryButton: UIButton!
    @IBOutlet weak var callRestaurantButton: UIButton!
    
    // description labels
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var aveCostForTwoLabel: UILabel!
    @IBOutlet weak var deliverableLabel: UILabel!
    @IBOutlet weak var reservableLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = restaurant?.restaurantName
        
        self.reviewTableView.separatorStyle = .none
        self.reviewTableView.rowHeight = UITableViewAutomaticDimension
        self.reviewTableView.estimatedRowHeight = 60
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReviewController.shared.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        
        let review = ReviewController.shared.reviews[indexPath.row]
        
        cell.review = review
        
        return cell
    }
    
    //MARK: - Actions
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard let restaurant = self.restaurant else { return }
        RestaurantController.shared.isFavoritedToggle(restaurant: restaurant)
    }
    
    @IBAction func callRestaurantButtonTapped(_ sender: UIButton) {
        self.callRestaurantAlert()
    }
    
    //MARK: - Linking outlets to restaurant info
    
    func updateViews() {
        guard let restaurant = restaurant, let image = restaurant.imageURL else { return }
        
        RestaurantController.shared.fetchRestaurantImage(imageURL: image) { (image) in
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                self.restaurantNameLabel.text = restaurant.restaurantName
                self.restaurantAddressLabel.text = restaurant.address
                self.aveCostForTwoLabel.text = "Average Cost For Two: $\(restaurant.averageCostForTwo)"
                self.restaurantImageView.image = image
                self.convertDeliveryToString() // might not work properly
                self.convertReservableToString() // might not work properly
            }
        }
    }
    
    func convertDeliveryToString() {
        guard let restaurant = restaurant else { return }
        
        if restaurant.deliveryOption == 0 {
            self.deliverableLabel.text = "Does Not Deliver"
        } else {
            self.deliverableLabel.text = "Delivers"
        }
    }
    
    func convertReservableToString() {
        guard let restaurant = restaurant else { return }
        
        if restaurant.reservable == 0 {
            self.reservableLabel.text = "Doesn't Take Reservations"
        } else {
            self.reservableLabel.text = "Takes Reservations"
        }
    }
    
    // MARK: - Call Restaurant Alert Controller
    
    func callRestaurantAlert() {
        guard let restaurant = self.restaurant, let restaurantName = restaurant.restaurantName else { return }
        RestaurantController.shared.fetchRestaurantPhoneNumber { (phoneNumber) in
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
