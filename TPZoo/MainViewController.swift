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


class MainViewController: UIViewController, CLLocationManagerDelegate {
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      print("xxx\(AnimalDataManager.shared.dessertAnimalMarkerDatas)")

        self.insertGoogleMapVC()
    }
    private func insertGoogleMapVC() {
        let vc = GoogleMapViewController.init(nibName: String.init(describing: GoogleMapViewController.self), bundle: nil)
        vc.view.frame = self.view.bounds
        self.view.addSubview(vc.view)
        self.addChildViewController(vc)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
