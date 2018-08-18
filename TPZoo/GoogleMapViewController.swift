//
//  GoogleMapViewController.swift
//  TPZoo
//
//  Created by HSI on 2018/8/15.
//  Copyright © 2018年 HSI. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapViewController: UIViewController {
    var locationManager: CLLocationManager!
    var mapView: GMSMapView!
    /**
     first loading delegate will callback twice
     */
    var firstLoadingLimitIgnore = false
   
    
    
    @IBOutlet weak var container: UIView!
    override func viewDidLoad() {
        self.loadGoogleMapSettingInViewDidAppear()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadGoogleMapSettingInViewDidAppear() {
        locationManager = GoogleMapManager.locationManager
        locationManager.delegate = self
        self.mapView = GoogleMapManager.mapView
        self.mapView.frame = container.bounds
        self.mapView.delegate = self
        self.container.addSubview(mapView)
        

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
//MARK: CLLocationManagerDelegate
extension GoogleMapViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        //        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom:zoomLevel)
        //        mapView.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }
}
//MARK: GMSMapViewDelegate
extension GoogleMapViewController: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if self.firstLoadingLimitIgnore {
            if (position.target.latitude > GoogleMapManager.coordinate.topLimitPoint.rawValue - GoogleMapManager.VerticalBoaderComplementary) {
                 GoogleMapManager.updateCamerapostion(limitSide: .topLimitPoint, respondPosition: position, mapView: self.mapView)
            }
            if (position.target.latitude < GoogleMapManager.coordinate.bottomLimitPoint.rawValue + GoogleMapManager.VerticalBoaderComplementary) {
                 GoogleMapManager.updateCamerapostion(limitSide: .bottomLimitPoint, respondPosition: position, mapView: self.mapView)
               
            }
            if (position.target.longitude < GoogleMapManager.coordinate.leftLimitPoint.rawValue + GoogleMapManager.HorizetalBoaderComplementary) {
                 GoogleMapManager.updateCamerapostion(limitSide: .leftLimitPoint, respondPosition: position, mapView: self.mapView)
             
            }
            if (position.target.longitude > GoogleMapManager.coordinate.rightLimitPoint.rawValue - GoogleMapManager.HorizetalBoaderComplementary) {
                 GoogleMapManager.updateCamerapostion(limitSide: .rightLimitPoint, respondPosition: position, mapView: self.mapView)
            }
        }else{
            if position.target.latitude == 24.99620900530806 && position.target.longitude == 121.58524207770824 {
                self.firstLoadingLimitIgnore = true
            }
        }
    }
    
}

