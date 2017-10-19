//
//  Font.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 10/19/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static var merriweatherLight: UIFont {
        guard let fontName = UIFont(name: "Merriweather-Light", size: 23.0) else { return UIFont() }
        return fontName
    }
    
    static var merriweatherLightItalic: UIFont {
        guard let fontName = UIFont(name: "Merriweather-LightItalic", size: 23) else { return UIFont() }
        return fontName
    }
}
