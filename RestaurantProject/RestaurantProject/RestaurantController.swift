//
//  RestaurantController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/13/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import CoreLocation
import MapKit

class RestaurantController {
    
    
    private var apiKey: String { return "ac0c5c9c0b899a64283b5da5ab2f835a" }
    private var headerKey: String { return "user-key" }
    private var nearbyRestaurantsKey: String { return "nearby_restaurants" }
    private var restaurantsKey: String { return "restaurants" }
    
    static let shared = RestaurantController()
    let imageCache = NSCache<NSString, AnyObject>()
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
    
    var favoritedRestaurants: [Restaurant] {
        return restaurants.filter({ (restaurant) -> Bool in
            return restaurant.isFavorited == true
        })
    }
    
    var toTryRestaurants: [Restaurant] {
        return restaurants.filter({ (restaurant) -> Bool in
            return restaurant.isOnToTryList == true
        })
    }
    
//    var searchedRestaurants: [Restaurant] = []
//    var restaurant: Restaurant?
    
    // MARK: - Retreive/Fetch
    
    func fetchNearbyRestaurants(completion: @escaping ([Restaurant]) -> Void = { _ in }) {
        
        guard let baseURL = self.baseURL else { completion([]); return }
        
        let coordinate = LocationManager.shared.fetchCurrentLocation() // if it doesn't work, talk to michael
        
        let url = baseURL.appendingPathComponent("geocode")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let latQueryItem = URLQueryItem(name: "lat", value: coordinate.latitude.description)
        let lonQueryItem = URLQueryItem(name: "lon", value: coordinate.longitude.description)
        
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
    
    func fetchRestaurants(bySearchTerm searchTerm: String?, selectedCuisines: [Cuisine], completion: @escaping ([Restaurant]) -> Void = { _ in }) {
        guard let baseURL = self.baseURL else { completion([]); return }
        
        let coordinate = LocationManager.shared.fetchCurrentLocation()
        
        let url = baseURL.appendingPathComponent("search")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let searchQueryItem = URLQueryItem(name: "q", value: searchTerm)
        let latQueryItem = URLQueryItem(name: "lat", value: coordinate.latitude.description)
        let lonQueryItem = URLQueryItem(name: "lon", value: coordinate.latitude.description)
        
        components?.queryItems = [searchQueryItem, latQueryItem, lonQueryItem]
        
        if selectedCuisines.count > 0 {
            let cuisineQueryItem = URLQueryItem(name: "cuisines", value: convertCuisineArrayToString(cuisines: selectedCuisines))
            components?.queryItems?.append(cuisineQueryItem)
        }
        
        guard let requestURL = components?.url else { completion([]); return }
        
        var request = URLRequest(url: requestURL)
        request.setValue(self.apiKey, forHTTPHeaderField: self.headerKey)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error found. \(#file) \(#function) \n\(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data, let responseDataString = String(data: data, encoding: .utf8) else { completion([]); return }
            
            guard let jsonDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:Any], let restaurantDicts = jsonDict[self.restaurantsKey] as? [[String:Any]] else { NSLog("unable to serialize JSON. \n\(responseDataString)"); completion([]); return }
            
            let restaurants = restaurantDicts.flatMap { Restaurant(dictionary: $0) }
      
            completion(restaurants)
        }
        dataTask.resume()
        
        // search?q=ruth&lat=40.7608&lon=-111.8910&cuisines=chinese
        // search?q=ruth&lat=40.7608&lon=-111.8910&cuisines=chinese%2C%20mexican
    }
    
    func fetchRestaurantImage(imageURLString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: imageURLString as NSString) as? UIImage {
            completion(cachedImage)
        }
        
        if imageURLString == "" {
            completion(#imageLiteral(resourceName: "ImageNotAvailable"))
        }
        
        guard let imageURL = URL(string: imageURLString) else { completion(nil); return }
        print("Fetching image for url: \(imageURL)")
        
        let dataTask = URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error { NSLog("unable to retreive image. Error: \(error.localizedDescription)"); completion(nil); return }
            
            guard let data = data, let image = UIImage(data: data) else { completion(nil); return }
            self.imageCache.setObject(image, forKey: imageURLString as NSString)
            
            completion(image)
        }
        dataTask.resume()
    }
    
    func fetchRestaurantPhoneNumber(restaurant: Restaurant, completion: @escaping (String) -> Void = { _ in }) {
//        guard let address = restaurant?.address else { return }
        
        guard let address = restaurant.address else { return }
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                NSLog("error found. \(#file) \(#function) \n\(error.localizedDescription)")
                return
            }
            guard let coordinates = placemarks?.first?.location?.coordinate else { return }
            let placemark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placemark)
            guard let phoneNumber = mapItem.phoneNumber else { return }
            completion(phoneNumber)
        }
    }
    
    func convertCuisineArrayToString(cuisines: [Cuisine]) -> String {
        var cuisinesString = ""
        
        for cuisine in cuisines {
            cuisinesString.append(cuisine.description + ", ")
        }
        
        cuisinesString.removeLast(2)
        return cuisinesString
    }
    
    func isFavoritedToggle(restaurant: Restaurant) {
        restaurant.isFavorited = !restaurant.isFavorited
        saveToStorage()
    }
    
    func toTryListToggle(restaurant: Restaurant) {
        restaurant.isOnToTryList = !restaurant.isOnToTryList
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

// developers.zomato.com/api/v2.1/geocode?lat=40.7608&lon=-111.8910

