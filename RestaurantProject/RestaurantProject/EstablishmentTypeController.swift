//
//  EstablishmentTypeController.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/15/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import Foundation
import CoreData

class EstablishmentTypeController {
    private var apiKey: String { return "ac0c5c9c0b899a64283b5da5ab2f835a" }
    private var headerKey: String { return "user-key" }
    private var establishmentsKey: String { return "establishments" }
    private var mockCityID: String { return "1213" }
    
    static let shared = EstablishmentTypeController()
    let baseURL = RestaurantController.shared.baseURL
    
    var establishmentTypes: [EstablishmentType] = []
    
    func fetchEstablishmentTypes(completion: @escaping ([EstablishmentType]) -> Void) {
        guard let baseURL = self.baseURL else { completion([]); return }
        
        let url = baseURL.appendingPathComponent("establishments")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let cityIDQueryItem = URLQueryItem(name: "city_id", value: self.mockCityID)
        
        components?.queryItems = [cityIDQueryItem]
        
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
            
            guard let jsonDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:Any], let establishmentsDicts = jsonDict[self.establishmentsKey] as? [[String:Any]] else { NSLog("unable to serialize JSON. n\(responseDataString)"); completion([]); return }
            
            let establishmentTypes = establishmentsDicts.flatMap { EstablishmentType(dictionary: $0) }
            completion(establishmentTypes)
        }
        dataTask.resume()
    }
}

// establishments?city_id=1213
