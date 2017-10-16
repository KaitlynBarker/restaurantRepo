//
//  RestaurantSearchTableViewController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/13/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class RestaurantSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
    }
    
    //MARK: - Actions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, searchTerm != "" else { return }
        
        let selectedCuisines = CuisineController.shared.selectedCuisines
        let location = LocationManager.shared.fetchCurrentLocation()
        
        RestaurantController.shared.fetchRestaurants(bySearchTerm: searchTerm, selectedCuisines: selectedCuisines, location: location) { (restaurants) in
            
            //
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let searchTerm = searchBar.text, searchTerm != "" else { return }
        
        let selectedCuisines = CuisineController.shared.selectedCuisines
        let location = LocationManager.shared.fetchCurrentLocation()
        
        RestaurantController.shared.fetchRestaurants(bySearchTerm: searchTerm, selectedCuisines: selectedCuisines, location: location) { (restaurants) in
            
            //
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RestaurantController.shared.restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantTableViewCell else { return UITableViewCell() }

        let restaurant = RestaurantController.shared.restaurants[indexPath.row]
        
        cell.restaurant = restaurant

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToRestaurantDetailVC" {
            guard let destinationVC = segue.destination as? RestaurantDetailsViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let restaurant = RestaurantController.shared.restaurants[indexPath.row]
            
            destinationVC.restaurant = restaurant
        }
    }

}
