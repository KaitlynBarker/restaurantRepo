//
//  ReviewTableView.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/14/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class ReviewTableView: UITableView {
    
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
    
    // MARK: - Navigation
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
