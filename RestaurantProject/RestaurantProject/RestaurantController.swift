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
    
    private var apiKey: String { return "ac0c5c9c0b899a64283b5da5ab2f835a" }
    private var headerKey: String { return "user-key" }
    private var nearbyRestaurantsKey: String { return "nearby_restaurants" }
    private var mockLatKey: String { return "40.7608" }
    private var mockLonKey: String { return "-111.8910" }
    
    static let shared = RestaurantController()
    let baseURL = URL(string: "https://developers.zomato.com/api/v2.1")
    
    var restaurants: [Restaurant] {
        let moc = CoreDataStack.context
        let request: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        
        do {
            return try moc.fetch(request)
        } catch {
            NSLog("Unable to fetch request. Error: \(error.localizedDescription)")
        }
        return []
    }
    
//    var thumbsDownedRestaurants: [Restaurant] {
//        let moc = CoreDataStack.context
//        let request: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
//        
//        do {
//            return try moc.fetch(request)
//        } catch {
//            NSLog("Unable to fetch request. Error: \(error.localizedDescription)")
//        }
//        return []
//    }
    
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
                let restaurantsDicts = jsonDictionary[self.nearbyRestaurantsKey] as? [[String:Any]] else { NSLog("unable to serialize JSON. n\(responseDataString)"); completion([]); return }
            
            let restaurants = restaurantsDicts.flatMap { Restaurant(dictionary: $0) }
            
            completion(restaurants)
        }
        dataTask.resume()
    }
    
    func isFavoritedToggle(restaurant: Restaurant) {
        restaurant.isFavorited = !restaurant.isFavorited
        saveToStorage()
    }
    
    func isThumbsDownToggle(restaurant: Restaurant) {
        restaurant.isThumbsDown = !restaurant.isThumbsDown
        saveToStorage()
    }
    
    func removeRestaurantFromList(restaurant: Restaurant) {
        restaurant.managedObjectContext?.delete(restaurant)
        saveToStorage()
    }
    
    func saveToStorage() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            NSLog("Unable to save restaurant. Error: \(error.localizedDescription)")
        }
    }
}

// import the information pulled from mapkit into the fetchRestaurant info function. so that we can get the latitude and longitude
