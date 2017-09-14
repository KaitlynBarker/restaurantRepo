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
    
    // keys that aren't in the api
    
    private static var isFavoritedKey: String { return "isFavorited" }
    private static var isThumbsDownKey: String { return "isThumbsDown" }
    
    // first layer keys
    
    private static var resIDKey: String { return "id" }
    private static var restaurantNameKey: String { return "name" }
    private static var cuisineKey: String { return "cuisines" }
    private static var priceRangeKey: String { return "price_range" }
    private static var deliveryOptionKey: String { return "is_delivering_now" }
    private static var reservableKey: String { return "has_table_booking" }
    private static var featuredImageKey: String { return "featured_image" }
    private static var averageCostForTwoKey: String { return "average_cost_for_two" }
    
    // location dictionary keys
    
    private static var addressKey: String { return "address" }
    
    // user rating dictionary keys
    
    private static var averageRatingKey: String { return "aggregate_rating" }
    private static var ratingTextKey: String { return "rating_text" }
    private static var numberOfVotesKey: String { return "votes" }
    
    // dictionary and array keys
    
    private static var restaurantDictionaryKey: String { return "restaurant" }
    private static var locationDictionaryKey: String { return "location" }
    private static var userRatingDictionaryKey: String { return "user_rating" }
    
    // convenience init
    
    convenience init?(dictionary: [String:Any], context: NSManagedObjectContext = CoreDataStack.context) {
        guard let restaurantDictionary = dictionary[Restaurant.restaurantDictionaryKey] as? [String:Any],
            let restaurantName = restaurantDictionary[Restaurant.restaurantNameKey] as? String,
            let resID = restaurantDictionary[Restaurant.resIDKey] as? String,
            let cuisine = restaurantDictionary[Restaurant.cuisineKey] as? String,
            let priceRange = restaurantDictionary[Restaurant.priceRangeKey] as? Int32,
            let deliveryOption = restaurantDictionary[Restaurant.deliveryOptionKey] as? Int32,
            let reservable = restaurantDictionary[Restaurant.reservableKey] as? Int32,
            let featuredImage = restaurantDictionary[Restaurant.featuredImageKey] as? String,
            let averageCostForTwo = restaurantDictionary[Restaurant.averageCostForTwoKey] as? Int32,
            let locationDictionary = restaurantDictionary[Restaurant.locationDictionaryKey] as? [String:Any],
            let address = locationDictionary[Restaurant.addressKey] as? String,
            let userRatingDictionary = restaurantDictionary[Restaurant.userRatingDictionaryKey] as? [String:Any],
            let averageRating = userRatingDictionary[Restaurant.averageRatingKey] as? String,
            let numberOfVotes = userRatingDictionary[Restaurant.numberOfVotesKey] as? String,
            let ratingText = userRatingDictionary[Restaurant.ratingTextKey] as? String else { return nil }
        
        self.init(context: context)
        self.restaurantName = restaurantName
        self.resID = resID
        self.address = address
        self.priceRange = priceRange
        self.reservable = reservable
        self.imageURL = featuredImage
        self.averageCostForTwo = averageCostForTwo
        self.deliveryOption = deliveryOption
        self.cuisine = cuisine
        self.averageRating = averageRating
        self.numberOfVotes = numberOfVotes
        self.ratingText = ratingText
    }
    
}
