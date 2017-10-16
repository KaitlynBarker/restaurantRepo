//
//  CuisineController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/15/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import Foundation
import CoreData

class CuisineController {
    private var apiKey: String { return "ac0c5c9c0b899a64283b5da5ab2f835a" }
    private var headerKey: String { return "user-key" }
    private var cuisinesKey: String { return "cuisines" }
    
    static let shared = CuisineController()
    let baseURL = RestaurantController.shared.baseURL
    
    var cuisines: [Cuisine] {
        let moc = CoreDataStack.context
        let request: NSFetchRequest<Cuisine> = Cuisine.fetchRequest()
        
        do {
            return try moc.fetch(request)
        } catch {
            NSLog("Unable to fetch request. Error: \(error.localizedDescription)")
        }
        return []
    }
    
    var selectedCuisines: [Cuisine] {
        return cuisines.filter({ (cuisine) -> Bool in
            return cuisine.isCuisineChosen == true
        })
    }
    
    func fetchCuisines(completion: @escaping ([Cuisine]) -> Void = { _ in }) {
        guard let baseURL = self.baseURL else { completion([]); return }
        
        let coordinate = LocationManager.shared.fetchCurrentLocation()
        
        let url = baseURL.appendingPathComponent(self.cuisinesKey)
        
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
                NSLog(error.localizedDescription)
                completion([])
                return
            }
            
            guard let data = data, let responseDataString = String(data: data, encoding: .utf8) else { completion([]); return }
            
            guard let jsonDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:Any], let cuisinesDicts = jsonDict[self.cuisinesKey] as? [[String:Any]] else { NSLog("unable to serialize JSON. n\(responseDataString)"); completion([]); return }
            
            let cuisines = cuisinesDicts.flatMap { Cuisine(dictionary: $0) }
            let sortedCuisines = cuisines.sorted(by: { (_ cuisine1, _ cuisine2) -> Bool in
                guard let cuisine1 = cuisine1.cuisineName, let cuisine2 = cuisine2.cuisineName else { return false }
                return cuisine1 < cuisine2
            })
            completion(sortedCuisines)
        }
        dataTask.resume()
    }
    
    func isCuisineChosenToggle(cuisine: Cuisine) {
        cuisine.isCuisineChosen = !cuisine.isCuisineChosen
        saveToStorage()
    }
    
    func saveToStorage() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            NSLog("Unable to save cuisine. Error: \(error.localizedDescription)")
        }
    }
}

