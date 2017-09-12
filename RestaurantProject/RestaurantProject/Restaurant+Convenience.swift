//
//  Restaurant+Convenience.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/12/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import Foundation
import CoreData

extension Restaurant {
    
    private static var restaurantNameKey: String { return "name" }
    private static var resIDKey: String { return "id" }
    private static var addressKey: String { return "address" }
    private static var priceRangeKey: String { return "price_range" }
    private static var reservableKey: String { return "has_table_booking" }
    private static var deliveryOptionKey: String { return "is_delivering_now" }
    private static var cuisineKey: String { return "cuisines" }
    private static var isFavoritedKey: String { return "isFavorited" }
    private static var isThumbsDownKey: String { return "isThumbsDown" }
    private static var averageRatingKey: String { return "aggregate_rating" }
    private static var numberOfVotesKey: String { return "votes" }
    private static var ratingTextKey: String { return "rating_text" }
    
    convenience init?(dictionary: [String:Any], context: NSManagedObjectContext = CoreDataStack.context) {
        guard let restaurantName = dictionary[Restaurant.restaurantNameKey] as? String,
            let resID = dictionary[Restaurant.resIDKey] as? String,
            let address = dictionary[Restaurant.addressKey] as? String,
            let priceRange = dictionary[Restaurant.priceRangeKey] as? Int32,
            let reservable = dictionary[Restaurant.reservableKey] as? Int32,
            let deliveryOption = dictionary[Restaurant.deliveryOptionKey] as? Int32,
            let cuisine = dictionary[Restaurant.cuisineKey] as? String,
            let isFavorited = dictionary[Restaurant.isFavoritedKey] as? Bool,
            let isThumbsDown = dictionary[Restaurant.isThumbsDownKey] as? Bool,
            let averageRating = dictionary[Restaurant.averageRatingKey] as? String,
            let numberOfVotes = dictionary[Restaurant.numberOfVotesKey] as? String,
            let ratingText = dictionary[Restaurant.ratingTextKey] as? String else { return nil }
        
        self.init(context: context)
        self.restaurantName = restaurantName
        self.resID = resID
        self.address = address
        self.priceRange = priceRange
        self.reservable = reservable
        self.deliveryOption = deliveryOption
        self.cuisine = cuisine
        self.isFavorited = isFavorited
        self.isThumbsDown = isThumbsDown
        self.averageRating = averageRating
        self.numberOfVotes = numberOfVotes
        self.ratingText = ratingText
    }
    
}
