//
//  PriceRangeSlider.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 10/19/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import UIKit

class PriceRangeSlider: UISlider {
    
    static let shared = PriceRangeSlider()
    
    var priceRangeSlider: PriceRangeSlider? {
        didSet {
            getValue()
        }
    }
    
    @IBAction func priceRangeChanged(_ sender: PriceRangeSlider) {
        self.getValue()
    }
    
    func getValue() {
        
        if var priceRangeValue = self.priceRangeSlider?.value {
            priceRangeValue = roundf(priceRangeValue)
        } else {
            return
        }
    }
}
