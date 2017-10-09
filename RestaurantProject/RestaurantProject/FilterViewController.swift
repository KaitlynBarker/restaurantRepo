//
//  FilterViewController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/15/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    
    @IBOutlet weak var priceRangeSlider: UISlider!
    @IBOutlet weak var establishmentTableView: UITableView!
    @IBOutlet weak var cuisineTableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == establishmentTableView {
            return EstablishmentTypeController.shared.establishmentTypes.count
        } else if tableView == cuisineTableView {
            return CuisineController.shared.cuisines.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let establishmentCell = tableView.dequeueReusableCell(withIdentifier: "EstablishmentTypeCell", for: indexPath) as? EstablishmentTypeTableViewCell, let cuisineCell = tableView.dequeueReusableCell(withIdentifier: "CuisineCell") as? CuisineTableViewCell else { return UITableViewCell() }
        
        let establishment = EstablishmentTypeController.shared.establishmentTypes[indexPath.row]
        let cuisine = CuisineController.shared.cuisines[indexPath.row]
        
        if tableView == establishmentTableView {
            establishmentCell.establishmentType = establishment
            return establishmentCell
        } else if tableView == cuisineTableView {
            cuisineCell.cuisine = cuisine
            return cuisineCell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
