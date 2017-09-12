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
    private static var ratingKey: String { return "rating" }
    private static var ratingTextKey: String { return "rating_text" }
    private static var reviewPostTimeKey: String { return "review_time_friendly" }
    private static var reviewTextKey: String { return "review_text" }
    
    convenience init?(dictionary: [String:Any], context: NSManagedObjectContext = CoreDataStack.context) {
        guard let rating = dictionary[Review.ratingKey] as? Int32,
            let ratingText = dictionary[Review.ratingTextKey] as? String,
            let reviewPostTime = dictionary[Review.reviewPostTimeKey] as? String,
            let reviewText = dictionary[Review.reviewTextKey] as? String else { return nil }
        
        self.init(context: context)
        self.rating = rating
        self.ratingText = ratingText
        self.reviewPostTime = reviewPostTime
        self.reviewText = reviewText
    }
}
