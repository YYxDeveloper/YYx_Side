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
//     let arr = DataManager.shared.animalsSummaryData
//        print(arr)
//        print(Double(dou))
        
       print( DataManager.shared.animalsCoordinate)
        //        let predicate: NSPredicate = NSPredicate(format: "aLocation = %@", "兩棲爬蟲動物館")
        //        request.predicate = predicate
       
        
        
        let str = "MULTIPOINT ((121.5898494 24.9940697), (121.586726 24.994559), (121.5873295 24.9946641))"
     
    let aa =  String.convertCoordinateStringToFloat(targetString: str)
//        print(aa)

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
