//
//  RestaurantController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/13/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import Foundation
import CoreData
//import MapKit

class RestaurantController {
    
    static let shared = RestaurantController()
    
    private var apiKey: String { return "ac0c5c9c0b899a64283b5da5ab2f835a" }
    private var headerKey: String { return "user-key" }
    private var mockLatKey: String { return "40.7608" }
    private var mockLonKey: String { return "-111.8910" }
    
    let baseURL = URL(string: "https://developers.zomato.com/api/v2.1")
    
    func fetchRestaurantInfo(/*latitude: MKMapItem, longitude: MKMapItem,*/ completion: @escaping ([Restaurant]) -> Void) {
        
        guard let baseURL = self.baseURL else { completion([]); return }
        
        let url = baseURL.appendingPathComponent("geocode")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let latQueryItem = URLQueryItem(name: "lat", value: self.mockLatKey)
        let lonQueryItem = URLQueryItem(name: "lon", value: self.mockLonKey)
        
        components?.queryItems = [latQueryItem, lonQueryItem]
        
        guard let requestURL = components?.url else { completion([]); return }
        
        var request = URLRequest(url: requestURL)
        request.setValue(self.apiKey, forHTTPHeaderField: self.headerKey)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([])
                return
            }
            
            guard let data = data, let responseDataString = String(data: data, encoding: .utf8) else { completion([]); return }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:Any],
                let restaurantsDicts = jsonDictionary["nearby_restaurants"] as? [[String:Any]] else { NSLog("unable to serialize JSON. n\(responseDataString)"); completion([]); return }
            
            let restaurants = restaurantsDicts.flatMap { Restaurant(dictionary: $0) }
            
            completion(restaurants)
        }
        dataTask.resume()
    }
}

// import the information pulled from mapkit into the fetchRestaurant info function. so that we can get the latitude and longitude
