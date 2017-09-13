//
//  Review+Convenience.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/12/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import Foundation
import CoreData

extension Review {
    
    // dictionary and array keys
    
    private static var reviewDictionaryKey: String { return "review" }
    
    // keys in review dictionary
    
    private static var ratingKey: String { return "rating" }
    private static var ratingTextKey: String { return "rating_text" }
    private static var reviewPostTimeKey: String { return "review_time_friendly" }
    private static var reviewTextKey: String { return "review_text" }
    
    convenience init?(dictionary: [String:Any], context: NSManagedObjectContext = CoreDataStack.context) {
        guard let reviewDictionary = dictionary[Review.reviewDictionaryKey] as? [String:Any],
            let rating = reviewDictionary[Review.ratingKey] as? Int32,
            let ratingText = reviewDictionary[Review.ratingTextKey] as? String,
            let reviewPostTime = reviewDictionary[Review.reviewPostTimeKey] as? String,
            let reviewText = reviewDictionary[Review.reviewTextKey] as? String else { return nil }
        
        self.init(context: context)
        self.rating = rating
        self.ratingText = ratingText
        self.reviewPostTime = reviewPostTime
        self.reviewText = reviewText
    }
}
