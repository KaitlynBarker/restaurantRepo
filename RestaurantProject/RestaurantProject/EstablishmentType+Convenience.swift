//
//  EstablishmentType+Convenience.swift
//  RestaurantProject
//
//  Created by Kaitlyn Barker on 9/15/17.
//  Copyright © 2017 Kaitlyn Barker. All rights reserved.
//

import Foundation
import CoreData

extension EstablishmentType {
    private static var establishmentTypeNameKey: String { return "name" }
    private static var establishmentDictionaryKey: String { return "establishment" }
    
    convenience init?(dictionary: [String:Any], context: NSManagedObjectContext = CoreDataStack.context) {
        guard let establishmentDictionary = dictionary[EstablishmentType.establishmentDictionaryKey] as? [String:Any],
            let estTypeName = establishmentDictionary[EstablishmentType.establishmentTypeNameKey] as? String else { return nil }
        
        self.init(context: context)
        self.typeName = estTypeName
    }
}
