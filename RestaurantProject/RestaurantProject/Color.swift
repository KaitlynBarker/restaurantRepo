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
    
    // MARK: - first choice
    
    class var bloodOrange10: UIColor {
        return UIColor(hex: "EF552B")
    }
    
    class var babyBlue: UIColor {
        return UIColor(hex: "65B7E2")
    }
    
    class var blueGrey60: UIColor {
        return UIColor(hex: "DAE3EC")
    }
    
    // MARK: - Other Colors From Pallette
    
    class var customWhite: UIColor {
        return UIColor(hex: "FFFFFF")
    }
    
    class var brightBabyBlue: UIColor {
        return UIColor(hex: "34A0D9")
    }
    
    class var dullBabyBlue: UIColor {
        return UIColor(hex: "94CCEB")
    }
    
    class var peach30: UIColor {
        return UIColor(hex: "F6A38B")
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
