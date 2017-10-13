//
//  FilterViewController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/15/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CuisineTableViewCellDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var priceRangeSlider: UISlider!
    @IBOutlet weak var cuisineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cuisineTableView.delegate = self
        self.cuisineTableView.dataSource = self
        
        CuisineController.shared.fetchCuisines { (_) in
            DispatchQueue.main.async {
                self.cuisineTableView.reloadData()
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CuisineController.shared.cuisines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CuisineCell", for: indexPath) as? CuisineTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        let cuisine = CuisineController.shared.cuisines[indexPath.row]
        
        cell.cuisine = cuisine
        
        return cell
    }
    
    // MARK: - CuisineTableViewCellDelegate
    
    func cuisineCellWasUpdated(cell: CuisineTableViewCell) {
        guard let cuisine = cell.cuisine else { return }
        CuisineController.shared.isCuisineChosenToggle(cuisine: cuisine)
        
        cell.updateViews()
    }
}
