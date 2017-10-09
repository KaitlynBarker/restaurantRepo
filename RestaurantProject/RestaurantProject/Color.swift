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
    
    class var peach: UIColor {
        return UIColor(hex: "FFE3D9")
    }
    
    class var lipstick: UIColor {
        return UIColor(hex: "B53F33")
    }
    
    class var wine: UIColor {
        return UIColor(hex: "3D0B07")
    }
    
    // MARK: - Other colors to mix
    
    class var palePink: UIColor {
        return UIColor(hex: "FCF1ED")
    }
    
    class var cherryRed: UIColor {
        return UIColor(hex: "C54938")
    }
    
    class var candyAppleRed: UIColor {
        return UIColor(hex: "D53D2D")
    }
    
    class var blushPink: UIColor {
        return UIColor(hex: "EC9C8F")
    }
    
    class var dullPeach: UIColor {
        return UIColor(hex: "DDBDB7")
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
