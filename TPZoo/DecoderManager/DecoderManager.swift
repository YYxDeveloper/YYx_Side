//
//  DecoderManager.swift
//  TPZoo
//
//  Created by HSI on 2018/7/24.
//  Copyright © 2018年 HSI. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class DecoderManager {
    static let shared =  DecoderManager()
    var animalsData:[AnimalsDataModel.animals]{
        do {
            let content = try loadBundleFile(name: "AnimalsJSONData", type: "txt")
            let JsonData = try JSONDecoder().decode(AnimalsDataModel.self, from: content.data(using: .utf8)!)
             return JsonData.result.results
        } catch  {
            print("\(ERORR_PREFIX)\(error.localizedDescription)")
            return [AnimalsDataModel.animals]()
        }
    }
    
    private func loadBundleFile(name:String,type:String)throws -> String{
        //    https://www.hackingwithswift.com/example-code/strings/how-to-load-a-string-from-a-file-in-your-bundle
        guard let filepath = Bundle.main.path(forResource: name, ofType: type)  else {
            return "\(ERORR_PREFIX)\(#file):\(#line)"
        }

        let contents = try String(contentsOfFile: filepath)
        return contents
    }
    //MARK: CoreData
    private func coreDataHasSaved() -> Bool{
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
    private func saveAnimalsCoreData() {
        guard let entity = NSEntityDescription.entity(forEntityName: "AnimalObject", in: getViewContext()) else {
            print("\(ERORR_PREFIX)\(#file):\(#line)")
            return}
        let newAnimal = NSManagedObject(entity: entity, insertInto: getViewContext())
        newAnimal.setValue("myname", forKey: "aNameCh")
        
        do {
            try getViewContext().save()
        } catch {
            print("\(ERORR_PREFIX)\(error.localizedDescription)")
        }
        
    }
     func loadAnimalsCoreData()  {
            let request: NSFetchRequest<AnimalObject> = AnimalObject.fetchRequest()
            do {
//                let enityCount = try context.count(for: request)
                let arr = try getViewContext().fetch(request)
                _ = arr.map({print($0.aNameCh ?? "fuck")})
            } catch {
                print("\(ERORR_PREFIX)\(error.localizedDescription)")
            }
        }
}
