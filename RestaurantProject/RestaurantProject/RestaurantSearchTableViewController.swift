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
    @IBOutlet weak var searchBackgroundView: UIView!
    
    var restaurants: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        self.view.backgroundColor = UIColor.customGrey
        self.searchBackgroundView.backgroundColor = UIColor.customGrey
        self.searchButton.backgroundColor = UIColor.customGrey
        self.searchBar.backgroundColor = UIColor.customGrey
        
        self.searchButton.titleLabel?.textColor = UIColor.customBlue
        
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60
        
        RestaurantController.shared.fetchNearbyRestaurants { (restaurants) in
            DispatchQueue.main.async {
                self.restaurants = restaurants
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Actions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, searchTerm != "" else { return }
        
        let selectedCuisines = CuisineController.shared.selectedCuisines
        
        RestaurantController.shared.fetchRestaurants(bySearchTerm: searchTerm, selectedCuisines: selectedCuisines) { (restaurants) in
            
            DispatchQueue.main.async {
                self.restaurants = restaurants
                self.tableView.reloadData()
            }
        }
        self.searchBar.resignFirstResponder()
        self.searchBar.text = ""
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let searchTerm = searchBar.text, searchTerm != "" else { return }
        
        let selectedCuisines = CuisineController.shared.selectedCuisines
        
        RestaurantController.shared.fetchRestaurants(bySearchTerm: searchTerm, selectedCuisines: selectedCuisines) { (restaurants) in
            
            DispatchQueue.main.async {
                self.restaurants = restaurants
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantTableViewCell else { return UITableViewCell() }

        let restaurant = self.restaurants[indexPath.row]
        
        cell.restaurant = restaurant
        
        DispatchQueue.main.async {
            if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexPath {
                print("Got image for now-reused cell")
                return
            }
            cell.setNeedsLayout()
        }

        return cell
    }

    // MARK: - Navigation

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToRestaurantDetailVC" {
            guard let destinationVC = segue.destination as? RestaurantDetailsViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let restaurant = self.restaurants[indexPath.row]
            
            destinationVC.restaurant = restaurant
        }
    }
}

extension RestaurantSearchTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let item = self.restaurants[indexPath.row]
            guard let imageURL = item.imageURL else { return }
            guard let itemURL = URL(string: imageURL) else { return }
            let dataTask = URLSession.shared.dataTask(with: itemURL)
            dataTask.resume()
        }
    }
}



