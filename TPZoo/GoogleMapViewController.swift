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
    var mapView = GMSMapView(){
        didSet{
            GoogleMapManager.shared.mapView = self.mapView
        }
    }
    /**
     first loading delegate will callback twice
     */
   
    
    
    //update anytime
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
        
        self.mapView = GoogleMapManager.shared.initMapView(model: .release)
        GoogleMapManager.shared.initDataSource()
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
        guard GoogleMapManager.shared.checkFirstLoading(position: position) else {return}
        self.mapView = GoogleMapManager.shared.changeMarkertype(with: position.zoom)
    }
    
}

