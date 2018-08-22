//
//  DataManager.swift
//  TPZoo
//
//  Created by HSI on 2018/7/25.
//  Copyright © 2018年 HSI. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SDWebImage
class DataManager {
//MARK: Enum
  
    let areaNameXCoordinate:[(String,Double,Double)]=[("臺灣動物區",24.998100, 121.580641),("溫帶動物區",24.993025, 121.590260),("兒童動物區",24.999100, 121.582282),("熱帶雨林區",24.994840, 121.583248),("澳洲動物區",24.994699, 121.585761),("沙漠動物區",24.994988, 121.58543),("非洲動物區",24.994482, 121.588234),("鳥園區",24.9957179,121.5888946)]
    let buildingNameXCoordinate:[(String,Double,Double)]  = [("大貓熊館",24.997391, 121.583110),("兩棲爬蟲館",24.994655, 121.589924),("昆蟲館",24.996735, 121.580545),("企鵝館",24.993035, 121.590771),("無尾熊館",24.9983738 ,121.5823688)]
    
    
    enum locationName{
        enum area:String{
            case 臺灣動物區,溫帶動物區,兒童動物區,熱帶雨林區,澳洲動物區,沙漠動物區,非洲動物區,鳥園區
        }
      
        enum building:String {
            case 昆蟲館,企鵝館,兩棲爬蟲館,無尾熊館,大貓熊館
        }
    }
    enum CoreDataType:String {
        case AnimalSummary,AnimalCoordinate,AnimalImages
    }
//MARK: Property
    static let shared =  DataManager()
    var animalsSummaryData:[AnimalSummary]{
        get{
            if self.hasCoreDataSaved(type: .AnimalSummary) {
                return loadAnimalsSummaryCoreData()
            }else{
                return saveJsonToAnimalSummaryCoreData()
            }
        }
       
    }
    var animalsCoordinate:[AnimalCoordinate] {
            if hasCoreDataSaved(type: .AnimalCoordinate) {
                return self.loadAnimalsCoordinateCoreData()
            }else{
                return  self.saveAnimalsCoordinateToCoreData()
            }
    }
    var animalsImages:[AnimalImages] {
        if hasCoreDataSaved(type: .AnimalCoordinate) {
            return self.loadAnimalImagesFromCoreData()
        }else{
            return  self.saveAnimalImagesToCoreData()
        }
    }
    
   
//MARK: AnimalSummary private func
    private func loadAnimalsSummaryCoreData() -> [AnimalSummary]{
        guard hasCoreDataSaved(type: .AnimalSummary) else {
            print("\(ERORR_PREFIX)\(#file):\(#line)")
            return  [AnimalSummary]()
        }
        
        let request: NSFetchRequest<AnimalSummary> = AnimalSummary.fetchRequest()
        do {
            let arr = try getViewContext().fetch(request)
//            _ = arr.map({print($0.aNameCh ?? EMPTY_STRING)})
    
        return arr
        } catch {
            print("\(ERORR_PREFIX)\(error.localizedDescription)")
        return [AnimalSummary]()
        }
    }
   private func saveJsonToAnimalSummaryCoreData() -> [AnimalSummary] {
            //                return JsonData.result.results
            _ = getJsonData().result.results.map({
                let newAnimal = getManagerObject(type: .AnimalSummary)
                    newAnimal.setValue($0.aAdopt, forKey: "aAdopt")
                    newAnimal.setValue($0.aAlsoKnown, forKey: "aAlsoKnown")
                    newAnimal.setValue($0.aBehavior, forKey: "aBehavior")
                    newAnimal.setValue($0.aCID, forKey: "aCID")
                    newAnimal.setValue($0.aClass, forKey: "aClass")
                    newAnimal.setValue($0.aCode, forKey: "aCode")
                    newAnimal.setValue($0.aConservation, forKey: "aConservation")
                    newAnimal.setValue($0.aCrisis, forKey: "aCrisis")
                    newAnimal.setValue($0.aDiet, forKey: "aDiet")
                    newAnimal.setValue($0.aDistribution, forKey: "aDistribution")
                    newAnimal.setValue($0.aFamily, forKey: "aFamily")
                    newAnimal.setValue($0.aFeature, forKey: "aFeature")
                    newAnimal.setValue($0.aGeo, forKey: "aGeo")
                    newAnimal.setValue($0.aHabitat, forKey: "aHabitat")
                    newAnimal.setValue($0.aInterpretation, forKey: "aInterpretation")
                    newAnimal.setValue($0.aKeywords, forKey: "aKeywords")
                    newAnimal.setValue($0.aLocation, forKey: "aLocation")
                    newAnimal.setValue($0.aNameCh, forKey: "aNameCh")
                    newAnimal.setValue($0.aNameEn, forKey: "aNameEn")
                    newAnimal.setValue($0.aNameLatin, forKey: "aNameLatin")
                    newAnimal.setValue($0.aOrder, forKey: "aOrder")
                    newAnimal.setValue($0.aPOIGroup, forKey: "aPOIGroup")
                    newAnimal.setValue($0.aPhylum, forKey: "aPhylum")
                    newAnimal.setValue($0.aPic01ALT, forKey: "aPic01ALT")
                    newAnimal.setValue($0.aPic01URL, forKey: "aPic01URL")
                    newAnimal.setValue($0.aPic02ALT, forKey: "aPic02ALT")
                    newAnimal.setValue($0.aPic02URL, forKey: "aPic02URL")
                    newAnimal.setValue($0.aPic03ALT, forKey: "aPic03ALT")
                    newAnimal.setValue($0.aPic03URL, forKey: "aPic03URL")
                    newAnimal.setValue($0.aPic04ALT, forKey: "aPic04ALT")
                    newAnimal.setValue($0.aPic04URL, forKey: "aPic04URL")
                    newAnimal.setValue($0.aSummary, forKey: "aSummary")
                    newAnimal.setValue($0.aThemeName, forKey: "aThemeName")
                    newAnimal.setValue($0.aThemeURL, forKey: "aThemeURL")
                    newAnimal.setValue($0.aUpdate, forKey: "aUpdate")
                    newAnimal.setValue($0.id, forKey: "id")
                    newAnimal.setValue($0.count, forKey: "count")
                
                do {
                    try getViewContext().save()
                } catch {
                    print("\(ERORR_PREFIX)\(error.localizedDescription)")
                }
            })
            
            return loadAnimalsSummaryCoreData()
    }
//MARK: AnimalsCoordinate private func
    private func loadAnimalsCoordinateCoreData() -> [AnimalCoordinate]{
      
        
        let request: NSFetchRequest<AnimalCoordinate> = AnimalCoordinate.fetchRequest()
        do {
            let arr = try getViewContext().fetch(request)
//            _ = arr.map({print($0.aNameEn ?? EMPTY_STRING)})
            return arr
        } catch {
            print("\(ERORR_PREFIX)\(error.localizedDescription)")
            return [AnimalCoordinate]()
        }
    }
    private func saveAnimalsCoordinateToCoreData()-> [AnimalCoordinate] {
        do {
            _ = try getJsonModel().result.results.map({
                guard let aEngName = $0.aNameEn else {throw yyxErorr.guardError}
                guard  let coordinateString = $0.aGeo else{throw yyxErorr.guardError}
                let coordinates = String.convertCoordinateStringToDouble(targetString: coordinateString)
                for each in coordinates{
                   
                    let coordinate = getManagerObject(type: .AnimalCoordinate)
                    coordinate.setValue(aEngName, forKey: "aNameEn")
                    coordinate.setValue(each.0, forKey: "lon")
                    coordinate.setValue(each.1, forKey: "lat")
                     try getViewContext().save()
                }
            })
        } catch  {
            print(error.localizedDescription)
            print("\(String.showFileName(filePath: #file)):\(#line)")
        }
        return  self.loadAnimalsCoordinateCoreData()
    }
//MARK: AnimalImages private func
     private func saveAnimalImagesToCoreData() -> [AnimalImages] {
        do {
            _ = try getJsonModel().result.results.map({
              let newAnimalImages = getManagerObject(type: .AnimalImages)
                newAnimalImages.setValue($0.aNameEn, forKey: "aNameEn")
                
                newAnimalImages.setValue($0.aPic01URL, forKey: "url1")
                newAnimalImages.setValue($0.aPic01ALT, forKey: "alt1")
                //image1
                
                newAnimalImages.setValue($0.aPic02URL, forKey: "url2")
                newAnimalImages.setValue($0.aPic02ALT, forKey: "alt2")
                
                newAnimalImages.setValue($0.aPic03URL, forKey: "url3")
                newAnimalImages.setValue($0.aPic03ALT, forKey: "alt3")
                
                newAnimalImages.setValue($0.aPic04URL, forKey: "url4")
                newAnimalImages.setValue($0.aPic04ALT, forKey: "alt4")
                
            })
            try getViewContext().save()
        } catch  {
            print(error.localizedDescription)
            print("\(String.showFileName(filePath: #file)):\(#line)")
        }
         return loadAnimalImagesFromCoreData()
        
    }
    private func loadAnimalImagesFromCoreData() -> [AnimalImages] {
        let request: NSFetchRequest<AnimalImages> = AnimalImages.fetchRequest()
        do {
            let arr = try getViewContext().fetch(request)
            return arr
        } catch {
            print("\(ERORR_PREFIX)\(error.localizedDescription)")
            return [AnimalImages]()
        }
    }

//MARK: Utility
    private func getJsonModel() throws ->AnimalsJsonDataModel {
        let content = try FileManager.loadBundleFile(name: "AnimalsJSONData", type: "txt")
        let JsonData = try JSONDecoder().decode(AnimalsJsonDataModel.self, from: content.data(using: .utf8)!)
        return JsonData
    }
    private func hasCoreDataSaved(type:CoreDataType) -> Bool{
        var enityCount = 0
        
        switch type {
        case .AnimalSummary:
            let request: NSFetchRequest<AnimalSummary> = AnimalSummary.fetchRequest()
            do {
                enityCount = try getViewContext().count(for: request)
            } catch {
                print("\(ERORR_PREFIX)\(error.localizedDescription)")
            }
        case .AnimalCoordinate:
            let request: NSFetchRequest<AnimalCoordinate> = AnimalCoordinate.fetchRequest()
            do {
                enityCount = try getViewContext().count(for: request)
            } catch {
                print("\(ERORR_PREFIX)\(error.localizedDescription)")
            }
        case .AnimalImages:
            let request: NSFetchRequest<AnimalImages> = AnimalImages.fetchRequest()
            do {
                enityCount = try getViewContext().count(for: request)
            } catch {
                print("\(ERORR_PREFIX)\(error.localizedDescription)")
            }
        }
        return enityCount == 0 ? false:true
    }
    private func getViewContext() -> NSManagedObjectContext{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)}
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
  
    func getJsonData() -> AnimalsJsonDataModel{
        do {
            let content = try FileManager.loadBundleFile(name: "AnimalsJSONData", type: "txt")
            let JsonData = try JSONDecoder().decode(AnimalsJsonDataModel.self, from: content.data(using: .utf8)!)
            return JsonData
        } catch  {
            print("\(ERORR_PREFIX)\(String.showFileName(filePath:#file)):\(#line)")
            print(error.localizedDescription)
            
        }
        
        return AnimalsJsonDataModel()
    }
    private func getManagerObject(type:CoreDataType) -> NSManagedObject{
        switch type {
        case .AnimalSummary:
            guard let imagesEntity = NSEntityDescription.entity(forEntityName: CoreDataType.AnimalSummary.rawValue, in: getViewContext()) else {
                print("\(ERORR_PREFIX)\(String.showFileName(filePath:#file)):\(#line)")
                return NSManagedObject()}
                return NSManagedObject(entity: imagesEntity, insertInto: getViewContext())
        case .AnimalCoordinate:
            guard let imagesEntity = NSEntityDescription.entity(forEntityName: CoreDataType.AnimalCoordinate.rawValue, in: getViewContext()) else {
                print("\(ERORR_PREFIX)\(String.showFileName(filePath:#file)):\(#line)")
                return NSManagedObject()}
                return NSManagedObject(entity: imagesEntity, insertInto: getViewContext())
        case .AnimalImages:
            guard let imagesEntity = NSEntityDescription.entity(forEntityName: CoreDataType.AnimalImages.rawValue, in: getViewContext()) else {
                print("\(ERORR_PREFIX)\(String.showFileName(filePath:#file)):\(#line)")
                return NSManagedObject() }
                return NSManagedObject(entity: imagesEntity, insertInto: getViewContext())
        }
    }
}
