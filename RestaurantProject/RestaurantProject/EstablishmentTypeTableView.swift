//
//  EstablishmentTypeTableView.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/15/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class EstablishmentTypeTableView: UITableView {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EstablishmentTypeController.shared.establishmentTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EstablishmentTypeCell", for: indexPath) as? EstablishmentTypeTableViewCell else { return UITableViewCell() }
        
        let establishmentType = EstablishmentTypeController.shared.establishmentTypes[indexPath.row]
        
        cell.establishmentType = establishmentType
        
        return cell
    }
}
