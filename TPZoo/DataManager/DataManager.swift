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

class DataManager {
    static let shared =  DataManager()
    var animalsData:[AnimalObject]{
        get{
            if self.hasCoreDataSaved() {
                //core data
                return loadAnimalsCoreData()
            }else{
                return saveJsonToCoreData()
            }
        }
       
    }
        //MARK: CoreData
    private func loadAnimalsCoreData() -> [AnimalObject]{
        guard hasCoreDataSaved() else {
            print("\(ERORR_PREFIX)\(#file):\(#line)")
            return  [AnimalObject]()
        }
        let request: NSFetchRequest<AnimalObject> = AnimalObject.fetchRequest()
        do {
            let arr = try getViewContext().fetch(request)
            _ = arr.map({print($0.aNameCh ?? EMPTY_STRING)})
    
        return arr
        } catch {
            print("\(ERORR_PREFIX)\(error.localizedDescription)")
        return [AnimalObject]()
        }
    }
    private func hasCoreDataSaved() -> Bool{
            let request: NSFetchRequest<AnimalObject> = AnimalObject.fetchRequest()
            var enityCount = 0
            do {
                enityCount = try getViewContext().count(for: request)
            } catch {
                print("\(ERORR_PREFIX)\(error.localizedDescription)")
            }
            
            return enityCount == 0 ? false:true
        }
        private func getViewContext() -> NSManagedObjectContext{
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)}
            let context = appDelegate.persistentContainer.viewContext
            return context
        }
   private func saveJsonToCoreData() -> [AnimalObject] {
        do {
            let content = try loadBundleFile(name: "AnimalsJSONData", type: "txt")
            let JsonData = try JSONDecoder().decode(AnimalsDataModel.self, from: content.data(using: .utf8)!)
            //                return JsonData.result.results
            _ = JsonData.result.results.map({
                
                guard let entity = NSEntityDescription.entity(forEntityName: "AnimalObject", in: getViewContext()) else {
                    print("\(ERORR_PREFIX)\(#file):\(#line)")
                    return}
                let newAnimal = NSManagedObject(entity: entity, insertInto: getViewContext())
                newAnimal.setValue($0.aNameCh, forKey: "aNameCh")
                
                do {
                    try getViewContext().save()
                } catch {
                    print("\(ERORR_PREFIX)\(error.localizedDescription)")
                }
            })
            let request: NSFetchRequest<AnimalObject> = AnimalObject.fetchRequest()
            let arr = try getViewContext().fetch(request)
            _ = arr.map({print($0.aNameCh ?? EMPTY_STRING)})
            print("ggg \(arr)")
            return loadAnimalsCoreData()
            
        } catch  {
            print("\(ERORR_PREFIX)\(error.localizedDescription)")
            
        }
        return [AnimalObject]()
        
    }
    private func loadBundleFile(name:String,type:String)throws -> String{
        //    https://www.hackingwithswift.com/example-code/strings/how-to-load-a-string-from-a-file-in-your-bundle
        guard let filepath = Bundle.main.path(forResource: name, ofType: type)  else {
            return "\(ERORR_PREFIX)\(#file):\(#line)"
        }
        
        let contents = try String(contentsOfFile: filepath)
        return contents
    }
  
    
}
