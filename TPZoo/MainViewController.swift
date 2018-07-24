//
//  MainViewController.swift
//  TPZoo
//
//  Created by HSI on 2018/7/24.
//  Copyright © 2018年 HSI. All rights reserved.
//

import UIKit
import CoreData
class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.saveCoreData()
//        self.loadCoreData()
      DecoderManager.shared.loadAnimalsCoreData()
        
    }
   
    func loadCoreData()  {
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let request: NSFetchRequest<AnimalObject> = AnimalObject.fetchRequest()
            let context = appDelegate.persistentContainer.viewContext
            do {
                let countNum = try context.count(for: request)
                print("ggg\(countNum)")
                let arr = try context.fetch(request)
                 _ = arr.map({print($0.aNameCh ?? "fuck")})
            } catch {
                print(error)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
