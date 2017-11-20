//
//  Color.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 10/9/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: - Color Pallette
    
    class var customMaroon: UIColor {
        return UIColor(hex: "3D0B07")
    }
    
    class var customIvory: UIColor {
        return UIColor(hex: "FCF1ED")
    }
    
    class var candyAppleRed: UIColor {
        return UIColor(hex: "D53D2D")
    }
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: 1)
    }
}
