//
//  RestaurantDetailsViewController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/13/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class RestaurantDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var restaurant: Restaurant?
    
    //MARK: - Outlets
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var reviewTableView: UITableView!
    
    // buttons
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var thumbsDownButton: UIButton!
    @IBOutlet weak var addToTryListButton: UIButton!
    @IBOutlet weak var callRestaurantButton: UIButton!
    
    // description labels
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var aveCostForTwoLabel: UILabel!
    @IBOutlet weak var deliverableLabel: UILabel!
    @IBOutlet weak var reservableLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = restaurant?.restaurantName
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
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    //MARK: - Actions
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        
    }

    @IBAction func thumbsDownButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func addToTryListButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func callRestaurantButtonTapped(_ sender: UIButton) {
        
    }
    
    //MARK: - Linking outlets to restaurant info
    
    func updateViews() {
        guard let restaurant = restaurant, let image = restaurant.imageURL else { return }
        
        RestaurantController.shared.fetchRestaurantImage(imageURL: image) { (image) in
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                self.restaurantNameLabel.text = restaurant.restaurantName
                self.restaurantAddressLabel.text = restaurant.address
                self.phoneNumberLabel.text = "" // get phone number from map kit
                self.aveCostForTwoLabel.text = "$\(restaurant.averageCostForTwo)"
                self.restaurantImageView.image = image
                
//                self.convertDeliveryToString() doesn't work right now. api doesn't know
//                self.convertReservableToString() same as above
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
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
