//
//  ThumbsDownTableViewController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 10/12/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class ThumbsDownTableViewController: UITableViewController, ThumbsDownTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RestaurantController.shared.thumbsDownRestaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThumbsDownCell", for: indexPath) as? ThumbsDownTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        let thumbsDownRestaurant = RestaurantController.shared.thumbsDownRestaurants[indexPath.row]
        
        cell.thumbsDownRes = thumbsDownRestaurant
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            guard let destinationVC = segue.destination as? RestaurantDetailsViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let thumbsDownRestaurant = RestaurantController.shared.thumbsDownRestaurants[indexPath.row]
            
            destinationVC.restaurant = thumbsDownRestaurant
        }
    }
    
    // MARK: - ThumbsDownTableViewCellDelegate
    
    func restaurantStatusWasUpdate(cell: ThumbsDownTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let thumbsDownRes = RestaurantController.shared.thumbsDownRestaurants[indexPath.row]
        
        RestaurantController.shared.isThumbsDownToggle(restaurant: thumbsDownRes)
        cell.updateViews()
    }

}
