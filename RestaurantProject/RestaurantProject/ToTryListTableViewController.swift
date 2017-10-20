//
//  ToTryListTableViewController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 10/13/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class ToTryListTableViewController: UITableViewController, ToTryListTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.customGrey
        self.tableView.backgroundColor = UIColor.customGrey
        
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RestaurantController.shared.toTryRestaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToTryCell", for: indexPath) as? ToTryListTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        let toTryRestaurant = RestaurantController.shared.toTryRestaurants[indexPath.row]
        
        cell.toTryRes = toTryRestaurant
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toTryRestaurant = RestaurantController.shared.toTryRestaurants[indexPath.row]
            RestaurantController.shared.removeRestaurantFromList(restaurant: toTryRestaurant)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToRestaurantDetailFromToTry" {
            guard let destinationVC = segue.destination as? RestaurantDetailsViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let toTryRestaurant = RestaurantController.shared.toTryRestaurants[indexPath.row]
            
            destinationVC.restaurant = toTryRestaurant
        }
    }
    
    // MARK: - ThumbsDownTableViewCellDelegate
    
    func restaurantStatusWasUpdate(cell: ToTryListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let thumbsDownRes = RestaurantController.shared.toTryRestaurants[indexPath.row]
        
        RestaurantController.shared.toTryListToggle(restaurant: thumbsDownRes)
        cell.updateViews()
    }

}
