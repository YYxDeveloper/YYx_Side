//
//  Coordinate+CoreDataProperties.swift
//  
//
//  Created by HSI on 2018/8/2.
//
//

import Foundation
import CoreData


extension Coordinate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coordinate> {
        return NSFetchRequest<Coordinate>(entityName: "Coordinate")
    }

    @NSManaged public var lon: Double
    @NSManaged public var lat: Double
    @NSManaged public var newRelationship: AnimalObject?

}
