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
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var zoomLevel: Float = 15.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
      
//        GoogleMapManager.shared.addGMSMarker(cordinate: CLLocationCoordinate2D(latitude: 24.997134, longitude: 121.585503))
        //test
    
//        print(aa)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        locationManager = GoogleMapManager.shared.locationManager
        locationManager.delegate = self
        self.mapView = GoogleMapManager.shared.mapView
        view = self.mapView
        
       
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
//        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom:zoomLevel)
//        mapView.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
