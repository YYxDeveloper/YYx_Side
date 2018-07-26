//
//  AnimalObject+CoreDataProperties.swift
//  
//
//  Created by HSI on 2018/7/26.
//
//

import Foundation
import CoreData


extension AnimalObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnimalObject> {
        return NSFetchRequest<AnimalObject>(entityName: "AnimalObject")
    }

    @NSManaged public var aAdopt: String?
    @NSManaged public var aAlsoKnown: String?
    @NSManaged public var aBehavior: String?
    @NSManaged public var aCID: String?
    @NSManaged public var aClass: String?
    @NSManaged public var aCode: String?
    @NSManaged public var aConservation: String?
    @NSManaged public var aCrisis: String?
    @NSManaged public var aDiet: String?
    @NSManaged public var aDistribution: String?
    @NSManaged public var aFamily: String?
    @NSManaged public var aFeature: String?
    @NSManaged public var aGeo: String?
    @NSManaged public var aHabitat: String?
    @NSManaged public var aInterpretation: String?
    @NSManaged public var aKeywords: String?
    @NSManaged public var aLocation: String?
    @NSManaged public var aNameCh: String?
    @NSManaged public var aNameEn: String?
    @NSManaged public var aNameLatin: String?
    @NSManaged public var aOrder: String?
    @NSManaged public var aPhylum: String?
    @NSManaged public var aPic01ALT: String?
    @NSManaged public var aPic01URL: String?
    @NSManaged public var aPic02ALT: String?
    @NSManaged public var aPic02URL: String?
    @NSManaged public var aPic03ALT: String?
    @NSManaged public var aPic03URL: String?
    @NSManaged public var aPic04ALT: String?
    @NSManaged public var aPic04URL: String?
    @NSManaged public var aPOIGroup: String?
    @NSManaged public var aSummary: String?
    @NSManaged public var aThemeName: String?
    @NSManaged public var aThemeURL: String?
    @NSManaged public var aUpdate: String?
    @NSManaged public var aVedioURL: String?
    @NSManaged public var count: String?
    @NSManaged public var id: String?

}
