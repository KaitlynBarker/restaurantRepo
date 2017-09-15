//
//  Cuisine+Convenience.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/15/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import Foundation
import CoreData

extension Cuisine {
    private static var cuisineNameKey: String { return "name" }
    private static var cuisineDictionaryKey: String { return "cuisine" }
    
    convenience init?(dictionary: [String:Any], context: NSManagedObjectContext = CoreDataStack.context) {
        guard let cuisineDictionary = dictionary[Cuisine.cuisineDictionaryKey] as? [String:Any],
            let cuisineName = cuisineDictionary[Cuisine.cuisineNameKey] as? String else { return nil }
        
        self.init(context: context)
        self.cuisineName = cuisineName
    }
}
