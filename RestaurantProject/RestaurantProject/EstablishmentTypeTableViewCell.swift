//
//  EstablishmentTypeTableViewCell.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/15/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class EstablishmentTypeTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var establishmentTypeName: UILabel!
    @IBOutlet weak var establishmentFilterButton: UIButton!
    
    //MARK: - Actions
    
    @IBAction func establishmentFilterButtonTapped(_ sender: UIButton) {
        
    }
    
    var establishmentType: EstablishmentType? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let establishmentType = establishmentType else { return }
        establishmentTypeName.text = establishmentType.typeName
        
        if establishmentType.isEstablishmentTypeChosen {
            establishmentFilterButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            establishmentFilterButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }
}
