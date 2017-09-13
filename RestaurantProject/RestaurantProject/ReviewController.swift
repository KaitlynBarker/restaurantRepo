//
//  ReviewController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/13/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import Foundation
import CoreData

class ReviewController {
    
    static let shared = ReviewController()
    
    private var apiKey: String { return "ac0c5c9c0b899a64283b5da5ab2f835a" }
    private var headerKey: String { return "user-key" }
    private var userReviewsKey: String { return "user_reviews" }
    private var mockResIDKey: String { return "17234613" }
    
    let baseURL = RestaurantController.shared.baseURL
    
    func fetchReviews(completion: @escaping ([Review]) -> Void) {
        guard let baseURL = self.baseURL else { completion([]); return }
        
        let url = baseURL.appendingPathComponent("reviews")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let resIDQueryItem = URLQueryItem(name: "res_id", value: self.mockResIDKey)
        
        components?.queryItems = [resIDQueryItem]
        
        guard let requestURL = components?.url else { completion([]); return }
        
        var request = URLRequest(url: requestURL)
        request.setValue(self.apiKey, forHTTPHeaderField: self.headerKey)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog(error.localizedDescription)
                completion([])
                return
            }
            
            guard let data = data, let responseDataString = String(data: data, encoding: .utf8) else { completion([]); return }
            
            guard let jsonDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:Any], let reviewsDict = jsonDict[self.userReviewsKey] as? [[String:Any]] else {
                NSLog("unable to serialize JSON. n\(responseDataString)")
                completion([])
                return
            }
            
            let reviews = reviewsDict.flatMap { Review(dictionary: $0) }
            
            completion (reviews)
        }
        dataTask.resume()
    }
}

// reviews?res_id=17234613

