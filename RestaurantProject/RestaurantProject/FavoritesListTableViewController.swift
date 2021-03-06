//
//  FavoritesListTableViewController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/15/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit
import CoreData

class FavoritesListTableViewController: UITableViewController, FavoriteTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        self.view.backgroundColor = UIColor.customIvory
        
        self.tableView.refreshControl = refreshControl
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60
        self.tableView.backgroundColor = UIColor.customIvory
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK: - Refresh func
    
    @objc func refresh() {
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RestaurantController.shared.favoritedRestaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        let favRestaurant = RestaurantController.shared.favoritedRestaurants[indexPath.row]
        
        cell.favoriteRes = favRestaurant
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favRestaurant = RestaurantController.shared.favoritedRestaurants[indexPath.row]
            RestaurantController.shared.removeRestaurantFromList(restaurant: favRestaurant)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToRestaurantDetailFromFavs" {
            guard let destinationVC = segue.destination as? RestaurantDetailsViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let favRestaurant = RestaurantController.shared.favoritedRestaurants[indexPath.row]
            
            destinationVC.restaurant = favRestaurant
        }
    }
    
    // MARK: - FavoriteTableViewCellDelegate
    
    func restaurantStatusWasUpdated(cell: FavoriteTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let favRestaurant = RestaurantController.shared.favoritedRestaurants[indexPath.row]
        
        RestaurantController.shared.isFavoritedToggle(restaurant: favRestaurant)
        cell.updateViews()
    }
}
