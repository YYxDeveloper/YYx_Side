//
//  MainViewController.swift
//  TPZoo
//
//  Created by HSI on 2018/7/24.
//  Copyright © 2018年 HSI. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let mapView = GoogleMapManager.newZooMapView()
        view = mapView
        GoogleMapManager.addGMSMarker(with: mapView, cordinate: CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20))
        //test
    
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
